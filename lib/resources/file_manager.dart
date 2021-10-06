import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Synchronous file Manager.
class FileManager {
  late File _file;

  FileManager(String filename) {
    _file = File(filename);
  }

  /// Returns the path of app documents directory.
  static Future<String> getAppDocumentsPath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    return appDocumentsDirectory.path;
  }

  /// Checks if the file already exists.
  bool exists() => _file.existsSync();

  /// Creates a new file.
  void create() {
    if (exists()) return;
    _file.createSync();
  }

  /// Writes [data] to the file.
  void write(String data, {FileMode mode = FileMode.append}) {
    _file.writeAsStringSync(data, mode: mode);
  }

  /// Reads the file.
  String read() {
    if (!exists()) create();
    return _file.readAsStringSync();
  }
}
