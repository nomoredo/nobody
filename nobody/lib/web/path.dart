import 'package:nobody/references.dart';

import 'any_path.dart';

/// Path
/// has a path property
class RelativePath implements AnyPath {
  final String name;
  Future<String> get path async {
    var dir = await Directory.current;
    return '${dir.path}/$name';
  }

  const RelativePath(this.name);
}

class AbsolutePath implements AnyPath {
  final String name;
  Future<String> get path async {
    return name;
  }

  const AbsolutePath(this.name);
}
