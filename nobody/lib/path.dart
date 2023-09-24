import 'package:nobody/references.dart';

/// AbstractPath
/// has a path property
abstract class AbstractPath {
  Future<String> get path;
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

class SimplePath implements AbstractPath {
  final String name;
  Future<String> get path async {
    return name;
  }

  const SimplePath(this.name);
}
