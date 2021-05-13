//
//  BridgeService.swift
//  Runner
//
//  Created by STV Mac Book Pro on 2021/05/13.
//

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
