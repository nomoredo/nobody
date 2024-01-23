import 'package:nobody/references.dart';
import 'package:nobody/web/any_path.dart';

/// AbstractDownloadable
/// has a download method
abstract class AnyDownloadable {
  String get name;
  Future<Online> download(Online browser, AnyPath path);
}
