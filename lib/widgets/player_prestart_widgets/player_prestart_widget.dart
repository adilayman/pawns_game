import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:pawns_game/providers/player_prestart_provider.dart';
import 'package:pawns_game/widgets/player_prestart_widgets/existing_player_widget.dart';
import 'package:pawns_game/widgets/player_prestart_widgets/new_player_widget.dart';
import 'package:pawns_game/widgets/player_prestart_widgets/player_prestart_home_widget.dart';

class PlayerPrestartWidget extends StatelessWidget {
  final String label;

  const PlayerPrestartWidget({Key? key, required this.label}) : super(key: key);

  /// Creates a current prestart Widget.
  Widget _createCurrentPrestartWidget(PlayerPrestartProvider model) {
    if (model.state == PlayerPrestartState.home) {
      return PrestartHomeWidget(
        onPressedExisting: () =>
            model.state = PlayerPrestartState.existingPlayer,
        onPressedNew: () => model.state = PlayerPrestartState.newPlayer,
      );
    } else if (model.state == PlayerPrestartState.newPlayer) {
      return ChangeNotifierProvider.value(
        value: model.newPlayerProvider,
        child: const NewPlayerWidget(),
      );
    } else if (model.state == PlayerPrestartState.existingPlayer) {
      return ChangeNotifierProvider.value(
        value: model.existingPlayerProvider,
        child: const ExistingPlayerWidget(),
      );
    } else {
      return Container();
    }
  }

  /// Returns a back button to the previous prestart widget.
  Widget _backButton(PlayerPrestartProvider model) {
    /// There's no previous widget from prestart home widget.
    if (model.state == PlayerPrestartState.home) return Container();

    return IconButton(
      icon: const Icon(Icons.arrow_back),
      color: Colors.white,
      iconSize: 30,
      onPressed: () => model.state = PlayerPrestartState.home,
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
                style: const TextStyle(
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
