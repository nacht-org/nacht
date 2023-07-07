package org.nacht

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

@Suppress("PrivatePropertyName")
class MainActivity: FlutterActivity() {
    private val CHANNEL = "org.nacht/install_apk"
    private val INSTALL_REQUEST_CODE = 100
    
    override fun onPostResume() {
        super.onPostResume()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            window.setDecorFitsSystemWindows(false)
            window.navigationBarColor = 0
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result -> 
                if (call.method == "installApk") {
                    val context = applicationContext
                    val filePath = call.argument<String?>("filePath")
                    try {
                        installApk(context, filePath, result)
                    } catch (e: Exception) {
                        result.error("Failed to install APK", e.message, null)
                    }
                } else {
                    println(call.method)
                    result.notImplemented()
                }
            
        }
    }

    private fun installApk(context: Context, filePath: String?, result: MethodChannel.Result) {
        if (filePath == null) {
            result.error("File path cannot be null", null, null)
            return                   
        }

        val apkFile = File(filePath)

        val intent = Intent(Intent.ACTION_VIEW)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            val contentUri = FileProvider.getUriForFile(
                context,
                "${context.applicationContext.packageName}.fileprovider",
                apkFile
            )
            intent.setDataAndType(contentUri, "application/vnd.android.package-archive")
        } else {
            intent.setDataAndType(Uri.fromFile(apkFile), "application/vnd.android.package-archive")
        }
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        context.startActivity(intent)

        result.success(null)
    }
}
