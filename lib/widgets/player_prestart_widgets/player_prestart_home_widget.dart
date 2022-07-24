import 'package:flutter/material.dart';

import 'package:pawns_game/widgets/standard_widgets/app_button.dart';

class PrestartHomeWidget extends StatelessWidget {
  final Function onPressedExisting;
  final Function onPressedNew;

  const PrestartHomeWidget({
    Key? key,
    required this.onPressedExisting,
    required this.onPressedNew,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Existing player button.
        AppButton(
          text: "Existing player",
          onPressed: () => onPressedExisting(),
        ),

        // New player button.
        AppButton(
          text: "New player",
          onPressed: () => onPressedNew(),
        ),
      ],
    );
  }
}
