import 'dart:convert';

import 'package:crypton/crypton.dart';
import 'package:mobile_warehouse/main.dart';

class RSAGenerator {
  static String generateKey(String apiVersion) {
    final String timestamp =
        DateTime.now().millisecondsSinceEpoch.toRadixString(16);
    final Map<String, dynamic> messageMap = <String, dynamic>{
      'timestamp': timestamp,
      'platform': 'app',
      'apiVersion': '1.2.9',
    };
    final String message = jsonEncode(messageMap);
    final RSAPublicKey publicKey = RSAPublicKey.fromString(apiPublicKey);
    final String encrypted = publicKey.encrypt(message);
    return encrypted;
  }
}
