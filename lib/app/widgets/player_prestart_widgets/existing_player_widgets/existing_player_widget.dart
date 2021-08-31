import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:pawns_game/app/providers/prestart_providers/player_prestart_provider/existing_player_provider.dart';
import 'package:pawns_game/app/models/application_models/player.dart';
import 'package:pawns_game/app/widgets/player_widgets/wins_indicator_widget.dart';

class ExistingPlayerWidget extends StatelessWidget {
  /// Returns a list of existing players.
  List<DropdownMenuItem> _dropDownMenuItems(ExistingPlayerProvider model) {
    return model.players.map<DropdownMenuItem<Player>>((Player player) {
      return DropdownMenuItem<Player>(
        value: player,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(player.name),
            WinsIndicatorWidget(
              wins: player.wins.toString(),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExistingPlayerProvider>(
      builder: (context, model, _) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            color: Colors.white,
            height: 50,
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: DropdownButton<Player>(
              value: model.currentPlayer,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              isExpanded: true,
              style: TextStyle(color: Colors.blueGrey.shade900),
              underline: Container(height: 2, color: Colors.blueGrey.shade900),
              onChanged: (Player newPlayer) => model.currentPlayer = newPlayer,
              items: _dropDownMenuItems(model),
            ),
          ),
        );
      },
    );
  }
}
