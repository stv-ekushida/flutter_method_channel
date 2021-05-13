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
