import 'dart:async';
import 'dart:convert' show jsonDecode;
import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import 'i18n_config.dart';
import 'i18n_template.dart';
import 'logger.dart';

const int serverPort = 31313;
Logger logger = Logger();

void resourceDartBuilder(File workPath, String outputPath, bool isWatch) {
  final ResourceDartBuilder builder =
      ResourceDartBuilder(workPath.absolute.path, outputPath);
  builder.generateResourceDartFile();
  builder.isWatch = isWatch;
  builder.watchFileChange();
}

class ResourceDartBuilder {
  ResourceDartBuilder(this.projectRootPath, this.outputPath);

  bool isWatch = false;

  /// convert the set to the list
  I18nConfig? i18nConfig;

  /// all of the directory with yaml.
  List<FileSystemEntity> dirList = <FileSystemEntity>[];

  final bool isWriting = false;
  File? _resourceFile;

  void generateResourceDartFile() {
    print('Prepare generate resource dart file.');
    final String pubYamlPath = Platform.isMacOS
        ? '${projectRootPath}pubspec.yaml'
        : '$projectRootPath${separator}pubspec.yaml';
    try {
      final I18nConfig i18nconfig = I18nConfig.fromYaml(
        _getI18nConfig(pubYamlPath),
      );

      final String path = _getAbsolutePath(
        '${i18nconfig.localePath}${i18nconfig.defaultLocale}.json',
      );
      final Map<String, dynamic> i18nItems = getLocalizedString(
        Platform.isMacOS ? '$projectRootPath$path' : path,
      );

      generateI18n(i18nItems);
    } catch (e) {
      if (e is StackOverflowError) {
        writeText(e.stackTrace);
      } else {
        writeText(e);
      }
      print('error $e');
    }
    print('Generate dart resource file finish.');

    watchFileChange();
  }

  File get logFile => File('.dart_tool${separator}log.txt');

  final String projectRootPath;
  final String outputPath;

  /// write the
  /// default file is a log file in the .dart_tools/log.txt
  void writeText(Object? text, {File? file}) {
    file ??= logFile;
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file
      ..writeAsStringSync(DateTime.now().toString(), mode: FileMode.append)
      ..writeAsStringSync('  : $text', mode: FileMode.append)
      ..writeAsStringSync('\n', mode: FileMode.append);
  }

  /// get the flutter asset path from yaml
  YamlMap _getI18nConfig(String yamlPath) {
    final File file = File(yamlPath);
    dirList.add(file);
    print('yaml path: $yamlPath');
    final YamlMap map = loadYaml(file.readAsStringSync());
    // writeText(map.toString());
    final dynamic i18nConfigMap = map['i18nconfig'];
    if (i18nConfigMap is YamlMap) {
      // writeText("i18nConfigMap is yamlMap");
      return i18nConfigMap;
    }
    throw Error();
  }

  Map<String, dynamic> getLocalizedString(String path) {
    final File file = File(path);
    dirList.add(file);
    print('json path: $path');
    final Map<String, dynamic> json = jsonDecode(
      file.readAsStringSync(),
    );

    return json;
  }

  /// get the asset from yaml list
  List<String> getListFromYamlList(YamlList yamlList) {
    final List<String> list = <String>[];
    final List<String> r = yamlList.map((dynamic f) {
      // writeTempText("file = $f , type is ${f.runtimeType}");
      return f.toString();
    }).toList();
    list.addAll(r);
    return list;
  }

  String _getAbsolutePath(String path) {
    final File f = File(path);
    if (f.isAbsolute) {
      return path;
    }
    return '$projectRootPath/$path';
  }

  File get resourceFile {
    if (File(outputPath).isAbsolute) {
      _resourceFile ??= File(outputPath);
    } else {
      _resourceFile ??= File('$projectRootPath/$outputPath');
    }

    _resourceFile?.createSync(recursive: true);
    return _resourceFile!;
  }

  void generateI18n(Map<String, dynamic> i18nItems) {
    writeText('start write code');
    resourceFile.deleteSync(recursive: true);
    resourceFile.createSync(recursive: true);
    final IOSink lock = resourceFile.openWrite(mode: FileMode.append);
    final Function(String) generate = (String text) {
      lock.write(text);
    };

    final I18nTemplate template = I18nTemplate();
    generate(template.license);
    generate(template.classDeclare);
    generate(template.classDeclareFunctions);
    i18nItems.forEach((String key, dynamic value) {
      print('$key $value');
      generate(template.formatFiled(key, value));
    });
    generate(template.classDeclareFooter);
    lock.close();
    writeText('end write code');
  }

  /// watch all of path
  void watchFileChange() {
    if (!isWatch) return;

    isWatch = true;
    dirList.forEach((FileSystemEntity dir) {
      // ignore: cancel_subscriptions
      final StreamSubscription<FileSystemEvent>? sub = _watch(dir);
      if (sub != null) {
        watchMap[dir] = sub;
      }
    });

    print('watching files watch');
  }

  /// when the directory is change
  /// refresh the code
  StreamSubscription<FileSystemEvent>? _watch(FileSystemEntity file) {
    print(
        '[_watch] ${file.existsSync() ? '    is exists' : 'is not exists'} ${file.uri}');
    if (FileSystemEntity.isWatchSupported) {
      return file.watch().listen((FileSystemEvent data) {
        print('${data.path} is changed.');
        generateResourceDartFile();
      });
    }
    return null;
  }

  Map<FileSystemEntity, StreamSubscription<FileSystemEvent>> watchMap =
      <FileSystemEntity, StreamSubscription<FileSystemEvent>>{};

  void removeAllWatches() {
    watchMap.values.forEach((StreamSubscription<dynamic> v) {
      v.cancel();
    });
  }
}
