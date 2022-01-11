import 'package:yaml/yaml.dart';

class I18nConfig {
  I18nConfig(
    this.defaultLocale,
    this.localePath,
    this.generatedPath,
    this.locales,
    this.ltr,
    this.rtl,
  );

  I18nConfig.fromYaml(YamlMap yaml)
      : defaultLocale = yaml['defaultLocale'],
        localePath = yaml['localePath'],
        generatedPath = yaml['generatedPath'],
        locales = yaml['locales'],
        ltr = yaml['ltr'],
        rtl = yaml['rtl'];

  final String defaultLocale;
  final String localePath;
  final String generatedPath;

  final YamlList? locales;
  final YamlList? ltr;
  final YamlList? rtl;
}
