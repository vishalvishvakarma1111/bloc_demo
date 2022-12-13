package com.example.psspl_bloc_demo

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.BatteryManager.BATTERY_PROPERTY_CAPACITY
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.widget.Toast
import dev.flutter.example.NativeViewFactory
import io.flutter.plugin.common.MethodCall

class MainActivity : FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/battery"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngine.platformViewsController.registry.registerViewFactory("<platform-view-type>", NativeViewFactory())



        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler(fun(call: MethodCall, result: MethodChannel.Result) {

            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else if (call.method == "showToast") {
                val a = call.arguments;
                Toast.makeText(applicationContext, a.toString(), Toast.LENGTH_SHORT).show()

            } else {
                result.notImplemented()
            }


        })
    }


    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager;
        batteryLevel = batteryManager.getIntProperty(BATTERY_PROPERTY_CAPACITY)
        return batteryLevel


    }


}
