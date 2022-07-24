import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:pawns_game/providers/application.dart';
import 'package:pawns_game/screens/football_mode_screen.dart';
import 'package:pawns_game/screens/home_screen.dart';
import 'package:pawns_game/screens/loading_screen.dart';
import 'package:pawns_game/screens/prestart_screen.dart';

class ApplicationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    Application app = Application();

    return ChangeNotifierProvider(
      create: (_) => app,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (_) => LoadingScreen(route: '/prestart_screen'),
          '/prestart_screen': (_) => PrestartScreen(),
          '/home': (_) => HomeScreen(),
          '/football_game': (_) => FootballModeScreen(app),
        },
      ),
    );
  }
}
