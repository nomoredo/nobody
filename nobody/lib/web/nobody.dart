import '../references.dart';

class Nobody {
  static Future<Online> online(
      {bool visible = true,
      Duration? slow = null,
      Duration? timeout = null}) async {
    var browser = await puppeteer.launch(
        headless: !visible,
        noSandboxFlag: true,
        timeout: timeout ?? Duration(minutes: 5),
        slowMo: slow);
    return Online(browser, default_timeout: timeout ?? Duration(minutes: 5));
  }

  static Future<GraphServiceClient> at_office(String username) async {
    final built = await build_graph(username);
    return built;
  }

  static Future<T> open<T>(AbstractFile<T> file) async {
    return file.open();
  }
}

abstract class Text {
  String get text;
}

abstract class Attribute {
  String get attribute;
}

abstract class Timeout {
  Duration get timeout;
}

abstract class AbstractFile<T> {
  Future<T> open();
}

abstract class AbstractDocument {
  final String path;
  const AbstractDocument(this.path);
}
