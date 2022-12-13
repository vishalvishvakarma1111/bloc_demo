import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckBatteryLeveView extends StatefulWidget {
  const CheckBatteryLeveView({Key? key}) : super(key: key);

  @override
  State<CheckBatteryLeveView> createState() => _CheckBatteryLeveViewState();
}

class _CheckBatteryLeveViewState extends State<CheckBatteryLeveView> {
  String _batteryLevel = 'Unknown battery level.';
  static const platform = MethodChannel('samples.flutter.dev/battery');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
            ElevatedButton(
              onPressed: showToast,
              child: const Text('Show toast'),
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }

  void _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');

      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  void showToast() {
    try {
      platform.invokeMethod('showToast',"Hello how are you");
    } on PlatformException catch (e) {}
  }
}
