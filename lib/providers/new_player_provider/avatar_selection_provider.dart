import 'package:flutter/material.dart';
import 'package:gamez/gamez.dart';
import 'package:pawns_game/providers/application_providers/application.dart';

class AvatarSelectionProvider extends ChangeNotifier {
  ImageRenderer? _selectedAvatar;
  Application _app;

  late List<ImageRenderer?> _avatars;
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
  bool isSelected(ImageRenderer avatar) => identical(avatar, _selectedAvatar);

  set selectedAvatar(ImageRenderer? value) {
    _selectedAvatar = value;
    notifyListeners();
  }

  ImageRenderer? get selectedAvatar => _selectedAvatar;

  List<ImageRenderer?> get avatars => _avatars;
}
