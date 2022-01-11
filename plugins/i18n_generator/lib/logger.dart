// ignore_for_file: always_specify_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

class Logger {
  factory Logger() {
    return _instance ??= Logger._();
  }

  Logger._();

  static Logger? _instance;

  var isDebug = false;

  void debug(Object msg) {
    if (isDebug) {
      print(msg);
    }
  }
}
