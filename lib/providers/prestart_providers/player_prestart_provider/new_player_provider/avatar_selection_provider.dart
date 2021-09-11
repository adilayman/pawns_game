import 'package:flutter/material.dart';
import 'package:gamez/gamez.dart';

import 'package:pawns_game/providers/application_providers/application.dart';

class AvatarSelectionProvider extends ChangeNotifier {
  Sprite _selectedAvatar;
  Application _app;

  List<Sprite> _avatars;
  int _numberAvatars = 18;

  AvatarSelectionProvider(this._app) {
    _createAvatars();
    _selectedAvatar = _avatars[0];
  }

  /// Creates all avatars.
  void _createAvatars() {
    _avatars = [];
    for (int i = 1; i <= _numberAvatars; ++i) {
      String name = "assets/png/avatars/avatar_$i.png";
      _avatars.add(_app.sprites[name]);
    }
  }

  /// Checks if the [avatar] is selected.
  bool isSelected(Sprite avatar) => identical(avatar, _selectedAvatar);

  set selectedAvatar(Sprite value) {
    _selectedAvatar = value;
    notifyListeners();
  }

  Sprite get selectedAvatar => _selectedAvatar;

  List<Sprite> get avatars => _avatars;
}
