import 'package:mobile_warehouse/core/data/services/utils/user_agent.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

class ActionTRAKFlutterUserAgent implements UserAgent {
  @override
  Future<dynamic> getUserAgent() async => await userAgent();
}
