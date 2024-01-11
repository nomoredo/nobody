import 'package:nobody/references.dart';

/// AbstractPath
/// has a path property
abstract class AbstractPath {
  Future<String> get path;

  const AbstractPath();

  factory AbstractPath.Relative(String name) {
    return RelativePath(name);
  }

  factory AbstractPath.Absolute(String name) {
    return AbsolutePath(name);
  }
}

/// Path
/// has a path property
class RelativePath implements AbstractPath {
  final String name;
  Future<String> get path async {
    var dir = await Directory.current;
    return '${dir.path}/$name';
  }

  const RelativePath(this.name);
}

class AbsolutePath implements AbstractPath {
  final String name;
  Future<String> get path async {
    return name;
  }

  const AbsolutePath(this.name);
}
