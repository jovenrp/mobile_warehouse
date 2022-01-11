import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path_library;

import 'builder.dart';
import 'logger.dart';

// ignore_for_file: always_specify_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

String get separator => path_library.separator;

void main(List<String> args) {
  final ArgParser parser = ArgParser();
  parser.addFlag(
    'watch',
    abbr: 'w',
    defaultsTo: false, // not work well for now
    help: 'Continue to monitor changes after execution of orders.',
  );
  parser.addOption(
    'output',
    abbr: 'o',
    defaultsTo: 'lib${separator}const${separator}resource.dart',
    help:
        "Your resource file path. \nIf it's a relative path, the relative flutter root directory",
  );
  parser.addOption(
    'src',
    abbr: 's',
    defaultsTo: Platform.isMacOS ? '' : '.',
    help: 'Flutter project root path',
  );
  parser.addFlag('help', abbr: 'h', help: 'Help usage', defaultsTo: false);

  parser.addFlag('debug', abbr: 'd', help: 'debug info', defaultsTo: false);

  final results = parser.parse(args);

  Logger().isDebug = results['debug'];

  if (results.wasParsed('help')) {
    print(parser.usage);
    return;
  }

  final String path = results['src'];
  final String outputPath = results['output'];
  final workPath = File(path).absolute;
  print('Generate files for Project : ' + workPath.absolute.path);

  resourceDartBuilder(workPath, outputPath, results['watch']);
}
