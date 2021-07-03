import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:info2051_2018/app/screens/game_modes_screens/normal_mode_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NormalModeView(),
    );
  }
}
