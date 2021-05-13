import 'package:flutter/services.dart';

/// 機能単位にサービスを用意する
class BridgetService {
  static const platform = const MethodChannel('jp.co.stv-tech.method');

  const BridgetService._();

  /// メソッド1（引数なし、戻り値あり）
  static Future<String> getNoArgsWithReturnValue() async {
    try {
      final String result = await platform.invokeMethod('method1');
      return result;
    } on PlatformException catch (e) {
      return '${e.message}';
    }
  }

  /// メソッド2（引数あり、戻り値あり）
  static Future<String> getWithArgsWithReturnValue(String value) async {
    try {
      final Map args = <String, dynamic>{
        'value': value,
      };

      return await platform.invokeMethod('method2', args);
    } on PlatformException catch (e) {
      return '${e.message}';
    }
  }
}
