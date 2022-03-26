import 'package:flutter/material.dart';
import 'package:pawns_game/providers/application_providers/application.dart';
import 'package:pawns_game/providers/prestart_providers/player_prestart_provider.dart';
import 'package:pawns_game/providers/prestart_providers/prestart_provider.dart';
import 'package:pawns_game/widgets/player_prestart_widgets/player_prestart_widget.dart';
import 'package:pawns_game/widgets/standard_widgets/app_icon_button.dart';
import 'package:pawns_game/widgets/standard_widgets/app_name_widget.dart';
import 'package:pawns_game/widgets/standard_widgets/gradient_container.dart';
import 'package:pawns_game/widgets/standard_widgets/message_pop_up.dart';
import 'package:provider/provider.dart';

class PrestartScreen extends StatelessWidget {
  /// Returns a player prestart widget given a model.
  Widget _playerPrestartWidget(PlayerPrestartProvider ppModel, String label) {
    return Expanded(
      child: ChangeNotifierProvider(
        create: (context) => ppModel,
        child: PlayerPrestartWidget(label: label),
      ),
    );
  }

  /// Returns a start button.
  Widget _startButton(BuildContext context, PrestartProvider model) {
    return AppIconButton(
      onPressed: () {
        try {
          // verify players input if OK => redirect to the home screen.
          model.verifyPlayersInfo();
          Navigator.pushNamed(context, "/home");
        } catch (e) {
          // show a message popup if an error is detected.
          MessagePopUp(message: e.toString()).show(context);
        }
      },
      icon: Icons.play_arrow,
      primaryColor: Colors.green,
      secondaryColor: Color.fromRGBO(0, 5, 25, 0.25),
    );
  }

  @override
  Widget build(BuildContext context) {
    Application app = Provider.of<Application>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => PrestartProvider(app),
      child: Consumer<PrestartProvider>(
        builder: (context, model, _) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: GradientContainer(
              colors: app.standardGradient,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppNameWidget(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _playerPrestartWidget(model.firstPlayerProvider, "1"),
                        _playerPrestartWidget(model.secondPlayerProvider, "2"),
                      ],
                    ),
                  ),
                  _startButton(context, model),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
