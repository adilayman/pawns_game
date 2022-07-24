import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import 'package:pawns_game/providers/application.dart';
import 'package:pawns_game/widgets/player_widgets/player_avatar_widget.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Application app = Provider.of<Application>(context, listen: false);
    return Container(
      height: 80,
      color: const Color.fromRGBO(255, 255, 255, 0.25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // First player avatar with #wins.
          PlayerAvatarWidget(
            player: app.firstPlayer,
            trophyAlign: Alignment.bottomRight,
          ),

          // Second player avatar with #wins.
          PlayerAvatarWidget(
            player: app.secondPlayer,
            trophyAlign: Alignment.bottomLeft,
          ),
        ],
      ),
    );
  }
}
