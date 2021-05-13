# flutter_method_channel

Method Channel

## プラットフォーム側
ネイティブ連携機能ごとにサービスを用意する

### iOS

```
import Flutter
import Foundation

class BridgeService: NSObject {
    static let channel = "jp.co.stv-tech.method"
    static let callMethod1 = "method1"
    static let calLMethod2 = "method2"
    
    /// チャネル登録
    public static func register(controller: FlutterViewController) {
        let channel = FlutterMethodChannel(name: BridgeService.channel,
                                            binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            self.handle(call: call, result: result)

        })
    }
    
    /// ハンドリング
    private static func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
             
        if BridgeService.callMethod1 == call.method {
                result(method1())
        } else if BridgeService.calLMethod2 == call.method {
            
            guard let args = call.arguments as? [String: Any] else {
                result(FlutterError(code: "999",
                                    message: "引数エラー",
                                    details: "パラメターが正しく設定されていません。"))
                return
            }
            
            let value = args["value"] as! String
            result(method2(value: value))
        }
    }
    
    private static func method1() -> String {
        return "iOS : メソッド1"
    }

    private static func method2(value: String) -> String {
        return "iOS : メソッド2 : \(value)"
    }
}
```

AppDelegateにチャンネルを登録する。

```
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    BridgeService.register(controller: controller);
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### Android

```
package jp.co.stvtech.flutter_method_channel

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    companion object {
        private val CHANNEL = "jp.co.stv-tech.method"
        private const val METHOD1 = "method1"
        private const val METHOD2 = "method2"

    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->

            if(call.method == METHOD1) {
                result.success(method1())
            } else if (call.method == METHOD2) {
                val value = call.argument<String>("value").toString()
                result.success(method2(value))
            } else {
                result.notImplemented()
            }
        }
    }

    private fun method1(): String {
        return "Android : メソッド1"
    }

    private fun method2(value: String): String {
        return "Android : メソッド2 : $value"
    }
}
```

## Dart側
プラットフォーム側のメソッドを呼び出すクラスを用意する。

```
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
```

### 利用シーン

```
    BridgetService.getNoArgsWithReturnValue().then((value) {
      setState(() {
        platformValue = value;
      });
    });
     
```





