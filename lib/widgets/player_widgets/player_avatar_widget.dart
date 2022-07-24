import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:pawns_game/providers/application.dart';
import 'package:pawns_game/models/player.dart';
import 'package:pawns_game/widgets/player_widgets/wins_indicator_widget.dart';

class PlayerAvatarWidget extends StatelessWidget {
  final Player? player;
  final Alignment trophyAlign;

  PlayerAvatarWidget({required this.player, required this.trophyAlign});

  @override
  Widget build(BuildContext context) {
    Application app = Provider.of<Application>(context, listen: false);
    return Stack(
      alignment: trophyAlign,
      children: [
        RawImage(
          image: app.sprites[player!.avatar]!.image,
          width: 75,
          height: 75,
        ),
        WinsIndicatorWidget(wins: player!.wins.toString()),
      ],
    );
  }
}
