import 'dart:convert';

import 'package:http/http.dart'
    as http; // Add the import statement for the http package

import '../references.dart';

String getChromePath() {
  //get edge path
  return "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe";
}

final Nobody nobody = Nobody();

/// this is nobody
class Nobody {
  Nobody() {
    // showBanner();
  }

  Future<Online> online({
    bool visible = true,
    Duration? slow,
    Duration? timeout,
    String? browserWSEndpoint,
  }) async {
    Browser browser;

    final existingEndpoint = await findExistingChromeDevToolsEndpoint();
    if (existingEndpoint != null) {
      Show.info("connecting", "to", "existing",
          "browser instance found at $existingEndpoint");
      browser = await puppeteer.connect(
        browserWsEndpoint: existingEndpoint,
        slowMo: slow,
      );
    } else {
      // If no existing browser is found, launch a new instance.
      Show.info("launching", "new", "browser instance");
      browser = await puppeteer.launch(
        executablePath: getChromePath(),
        headless: !visible,
        args: [
          '--debug-port=9222',
          '--disable-infobars',
          '--disable-extensions',
          //disable everything we don't need.
          //especially the ones that might interfere with automation
          //keep it headful for now and use full window size for viewport
          '--viewport-size=1920,1080',
          '--no-sandbox',
          '--disable-setuid-sandbox',
          '--disable-web-security',
          '--disable-features=IsolateOrigins,site-per-process',
          '--disable-site-isolation-trials',
          '--ignore-certificate-errors',
          '--ignore-certificate-errors-spki-list',
          '--disable-extensions',
          '--disable-features=site-per-process',
          '--disable-accelerated-2d-canvas',
          '--disable-gpu',
          '--hide-scrollbars',
          '--disable-backgrounding-occluded-windows',
          '--disable-background-timer-throttling',
          '--disable-background-networking',
          '--disable-renderer-backgrounding',
          '--disable-ipc-flooding-protection',
          '--disable-notifications',
          '--disable-ipc-flooding-protection',
          '--disable-database',
          '--disable-geolocation',
          '--disable-media-cache',
          '--disable-metrics',
          '--disable-background-timer-throttling',
          '--disable-features=site-per-process',
          '--disable-features=site-per-process',
          '--disable-features=site-per-process',
        ],
        timeout: timeout ?? Duration(minutes: 5),
        slowMo: slow,
      );
    }

    // Ensure that the browser is closed when the program exits.
    browser.process?.exitCode.then((value) => browser.close());

    return Online(
      browser,
      default_timeout: timeout ?? Duration(minutes: 5),
    );
  }

  Future<String?> findExistingChromeDevToolsEndpoint() async {
    try {
      final response = await http.get(Uri.parse(
          "http://localhost:9222/json/version")); // Modify the code to use the http package
      final body = response.body;
      final endpointData = jsonDecode(body) as Map<String, dynamic>;
      return endpointData['webSocketDebuggerUrl'] as String?;
    } catch (e) {
      Show.warning("no existing", "chrome instance", "found");
    }
    return null; // No existing Chrome instance found
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
