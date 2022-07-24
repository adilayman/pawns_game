import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:pawns_game/providers/new_player_model.dart';
import 'package:pawns_game/widgets/player_prestart_widgets/avatar_selection_widget.dart';
import 'package:pawns_game/widgets/player_prestart_widgets/new_player_name_input.dart';

class NewPlayerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewPlayerProvider>(
      builder: (context, newPlayerProvider, _) {
        return Column(
          children: [
            NewPlayerNameInput(
              onSubmitted: (value) => newPlayerProvider.name = value,
            ),
            SizedBox(height: 25),
            ChangeNotifierProvider.value(
              value: newPlayerProvider.avatarSelectionProvider,
              child: AvatarSelectionWidget(),
            ),
          ],
        );
      },
    );
  }
}
