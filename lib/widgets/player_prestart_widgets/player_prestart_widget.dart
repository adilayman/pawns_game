import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:pawns_game/providers/player_prestart_provider.dart';
import 'package:pawns_game/widgets/player_prestart_widgets/existing_player_widget.dart';
import 'package:pawns_game/widgets/player_prestart_widgets/new_player_widget.dart';
import 'package:pawns_game/widgets/player_prestart_widgets/player_prestart_home_widget.dart';

class PlayerPrestartWidget extends StatelessWidget {
  final String label;

  PlayerPrestartWidget({required this.label});

  /// Creates a current prestart Widget.
  Widget _createCurrentPrestartWidget(PlayerPrestartProvider model) {
    if (model.state == PlayerPrestartState.Home)
      return PrestartHomeWidget(
        onPressedExisting: () =>
            model.state = PlayerPrestartState.ExistingPlayer,
        onPressedNew: () => model.state = PlayerPrestartState.NewPlayer,
      );
    else if (model.state == PlayerPrestartState.NewPlayer)
      return ChangeNotifierProvider.value(
        value: model.newPlayerProvider,
        child: NewPlayerWidget(),
      );
    else if (model.state == PlayerPrestartState.ExistingPlayer)
      return ChangeNotifierProvider.value(
        value: model.existingPlayerProvider,
        child: ExistingPlayerWidget(),
      );
    else
      return Container();
  }

  /// Returns a back button to the previous prestart widget.
  Widget _backButton(PlayerPrestartProvider model) {
    /// There's no previous widget from prestart home widget.
    if (model.state == PlayerPrestartState.Home) return Container();

    return IconButton(
      icon: const Icon(Icons.arrow_back),
      color: Colors.white,
      iconSize: 30,
      onPressed: () => model.state = PlayerPrestartState.Home,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerPrestartProvider>(
      builder: (context, model, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "SpaceBoards",
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(child: _createCurrentPrestartWidget(model)),
            _backButton(model),
          ],
        );
      },
    );
  }
}
