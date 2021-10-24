import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';

import 'package:pawns_game/providers/application_providers/application.dart';

class LoadingScreen extends StatelessWidget {
  /// Redirection route after loading.
  final String route;

  LoadingScreen({required this.route});

  @override
  Widget build(BuildContext context) {
    Application app = Provider.of<Application>(context, listen: false);
    return FutureBuilder(
      // Wait for all necessary resources to be loaded.
      future: app.loading(),
      builder: (context, snapshot) {
        // When ready => redirect to the chosen route.
        if (snapshot.connectionState == ConnectionState.done)
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, route);
          });

        return Scaffold(
          body: Container(
            color: Color.fromRGBO(0, 1, 22, 1),
            alignment: Alignment.center,
            child: Image(
              image: AssetImage("assets/png/app_logo.png"),
              width: 100,
              height: 100,
            ),
          ),
        );
      },
    );
  }
}
