import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

class Store<T> {
  final String storeName;
  final Future<Directory> Function() getDirectory;
  final Function(Uint8List) deserialize;
  final Function(T) serialize;

  Store({
    required this.storeName,
    this.getDirectory = _getDocumentDirectory,
    required this.deserialize,
    required this.serialize,
  });

  Future<String> get _localPath async {
    final directory = await getDirectory();
    return directory.path;
  }

  Future<Directory> get _localDirectory async {
    final path = await _localPath;
    return Directory('$path/$storeName')..createSync(recursive: true);
  }

  static Future<Directory> _getDocumentDirectory() async {
    final directory = await Directory.systemTemp.createTemp();
    final path = directory.path;
    return Directory('$path/.nothing')..createSync();
  }

  Future<void> set(String itemName, T value) async {
    final directory = await _localDirectory;
    final file = File('${directory.path}/$itemName');
    final bytes = serialize(value);
    await file.writeAsBytes(bytes, flush: true);
  }

  Future<T?> get(String itemName) async {
    try {
      final directory = await _localDirectory;
      final file = File('${directory.path}/$itemName');
      final bytes = await file.readAsBytes();
      final data = deserialize(bytes);
      return data as T?;
    } catch (e) {
      print("Error loading data: $e");
      return null;
    }
  }
}

///PasswordStore is a singleton that stores passwords in a file
final passwordStore = Store<String>(
  storeName: 'passwords',
  deserialize: (bytes) => String.fromCharCodes(bytes),
  serialize: (value) => value.codeUnits,
);
