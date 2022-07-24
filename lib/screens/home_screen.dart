import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:pawns_game/providers/application.dart';
import 'package:pawns_game/widgets/standard_widgets/gradient_container.dart';
import 'package:pawns_game/widgets/standard_widgets/app_name_widget.dart';
import 'package:pawns_game/widgets/standard_widgets/app_button.dart';
import 'package:pawns_game/widgets/home_widgets/home_top_bar.dart';
import 'package:pawns_game/widgets/standard_widgets/app_icon_button.dart';

class HomeScreen extends StatelessWidget {
  /// Returns a row widget of all game modes.
  Widget _gameModeButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Football game button
        AppButton(
          height: 80,
          text: "Football Game",
          onPressed: () => Navigator.pushNamed(context, "/football_game"),
        ),

        // Basketball game button: not available
        AppButton(
          height: 80,
          text: "Basketball Game",
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Application app = Provider.of<Application>(context, listen: false);
    return Scaffold(
      body: GradientContainer(
        colors: app.standardGradient,
        child: Stack(
          children: [
            HomeTopBar(),
            AppNameWidget(),
            Align(
              alignment: Alignment.center,
              child: _gameModeButtons(context),
            ),
            AppIconButton(
              onPressed: () => Navigator.pushNamed(context, "/prestart_screen"),
              icon: Icons.restart_alt,
              primaryColor: Colors.green.shade500,
              secondaryColor: Color.fromRGBO(0, 5, 25, 0.25),
            ),
          ],
        ),
      ),
    );
  }
}
