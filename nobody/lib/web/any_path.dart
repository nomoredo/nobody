import 'package:nobody/references.dart';

/// AbstractPath
/// has a path property
abstract class AnyPath {
  Future<String> get path;

  const AnyPath();

  factory AnyPath.Relative(String name) {
    return RelativePath(name);
  }

  factory AnyPath.Absolute(String name) {
    return AbsolutePath(name);
  }
}
