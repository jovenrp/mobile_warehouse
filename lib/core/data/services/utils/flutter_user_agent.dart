import 'package:mobile_warehouse/core/data/services/utils/user_agent.dart';

class ActionTRAKFlutterUserAgent implements UserAgent {
  @override
  Future<dynamic> getUserAgent() async => 'Android';
}
