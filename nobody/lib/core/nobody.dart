import '../references.dart';

class Nobody {
  Nobody() {
    showBanner();
  }

  Future<Online> online(
      {bool visible = true,
      Duration? slow = null,
      Duration? timeout = null}) async {
    var browser = await puppeteer.launch(
        headless: !visible,
        noSandboxFlag: true,
        timeout: timeout ?? Duration(minutes: 5),
        slowMo: slow);
    //ensure that the browser is closed when the program exits
    browser.process?.exitCode.then((value) => browser.close());

    return Online(browser, default_timeout: timeout ?? Duration(minutes: 5));
  }

  Future<GraphServiceClient> at_office(String username) async {
    final built = await build_graph(username);
    return built;
  }

  Future<T> open<T>(AbstractFile<T> file) async {
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
