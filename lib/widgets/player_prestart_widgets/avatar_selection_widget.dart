import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:pawns_game/providers/avatar_selection_provider.dart';

import 'package:gamez/gamez.dart';

class AvatarSelectionWidget extends StatelessWidget {
  /// Returns a check box widget for the selected avatar.
  Widget _checkBoxWidget(AvatarSelectionProvider model, ImageRenderer avatar) {
    return model.isSelected(avatar)
        ? Icon(Icons.check_circle_rounded, color: Colors.green.shade800)
        : Container();
  }

  /// Returns a button avatar widget.
  Widget _avatarWidget(AvatarSelectionProvider model, ImageRenderer avatar) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0.0),
        shape: CircleBorder(),
      ),
      onPressed: () => model.selectedAvatar = avatar,
      child: RawImage(
        image: avatar.image,
        width: 45,
        height: 45,
      ),
    );
  }

  /// Creates a list of buttons' avatars.
  List<Widget> _createAvatarButtons(AvatarSelectionProvider model) {
    List<Widget> widgets = [];
    model.avatars.forEach((avatar) {
      widgets.add(Stack(
        alignment: Alignment.topRight,
        children: [
          _avatarWidget(model, avatar!),
          _checkBoxWidget(model, avatar),
        ],
      ));
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AvatarSelectionProvider>(
      builder: (context, model, _) {
        return Expanded(
          child: GridView.count(
            childAspectRatio: 3 / 2,
            crossAxisCount: 5,
            children: _createAvatarButtons(model),
          ),
        );
      },
    );
  }
}
