package com.example.alfa_park_handheld_appv2;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.alfa_park_handheld_appv2";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("sayHello")) {
                                result.success(sayHello());
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private String sayHello() {
        return "HELLO FROM JAVA";
    }
}
