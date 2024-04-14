import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:http/http.dart'
    as http; // Add the import statement for the http package

import '../references.dart';

const LOCAL_EDGE_PATH =
    "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe";
const LOCAL_DOWNLOAD_SUBDIR = "./browser";
const LOCAL_DOWNLOAD_PATH = "./browser/msedge.exe";
// chromium download url is in the form https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/1287056/chrome-win.zip
// we need to replace the version number with the latest version number.
// we can get the latest version number from https://omahaproxy.appspot.com/all.json

const CHROMIUM_DOWNLOAD_SOURCE =
    "https://storage.googleapis.com/chromium-browser-snapshots/Win_x64/";

Future<String> getChromiumDownloadUrl() async {
  final response =
      await http.get(Uri.parse("https://omahaproxy.appspot.com/all.json"));
  final data = jsonDecode(response.body) as List<dynamic>;
  final latest =
      data.firstWhere((element) => element['os'] == 'win', orElse: () => null);
  if (latest != null) {
    final version = latest['versions'].firstWhere(
        (element) => element['channel'] == 'stable',
        orElse: () => null);
    if (version != null) {
      return "$CHROMIUM_DOWNLOAD_SOURCE${version['branch_base_position']}/chrome-win.zip";
    }
  }
  return "";
}

Future<String> getBrowserPath() async {
  //check if the edge path exists
  if (File(LOCAL_EDGE_PATH).existsSync()) {
    Show.info("browser found", "at", LOCAL_EDGE_PATH);
    return LOCAL_EDGE_PATH;
  } else {
    if (File(LOCAL_DOWNLOAD_PATH).existsSync()) {
      Show.info("browser found", "at", LOCAL_DOWNLOAD_PATH);
      return LOCAL_DOWNLOAD_PATH;
    } else {
      return await ask_user_for_prefered_browser();
    }
  }
}

Future<String> ask_user_for_prefered_browser() async {
  Show.warning("could not find", "edge browser", "at default path");
  final response = await Ask.confirmation("nobody ", "can download",
      "a local copy of browser for you", "would you like to proceed?");
  if (response) {
    Show.info("downloading", "edge browser", "for you");
    final download = await prepare_local_chromium();
    if (download) {
      return LOCAL_EDGE_PATH;
    } else {
      Show.error("could not", "download", "edge browser");
      return "";
    }
  } else {
    Show.error("no browser", "no automation");
    return "";
  }
}

Future<bool> prepare_local_chromium() async {
  final downloadUrl = await getChromiumDownloadUrl();
  //download the zip file
  final download = await downloadFile(downloadUrl, LOCAL_DOWNLOAD_SUBDIR);
  if (!download) {
    Show.error("could not", "download", "edge browser");
    return false;
  }
  //unzip the file
  final unzip = await unzipFile(LOCAL_DOWNLOAD_PATH, LOCAL_DOWNLOAD_SUBDIR);
  if (!unzip) {
    Show.error("could not", "unzip", "edge browser");
    return false;
  }
  return true;
}

Future<bool> downloadFile(String url, String subdir) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final bytes = response.bodyBytes;
    final file = File("$subdir/chrome-win.zip");
    await file.writeAsBytes(bytes);
    return true;
  }
  return false;
}

Future<bool> unzipFile(String path, String subdir) async {
  final zipFile = File(path);
  final bytes = zipFile.readAsBytesSync();
  final archive = ZipDecoder().decodeBytes(bytes);

  for (final file in archive) {
    final filename = "$subdir/${file.name}";
    if (file.isFile) {
      final data = file.content as List<int>;
      final f = File(filename);
      await f.create(recursive: true);
      await f.writeAsBytes(data);
    } else {
      final dir = Directory(filename);
      await dir.create(recursive: true);
    }
  }
  return true;
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
    bool devtools = false,
    int width = 1920,
    int height = 1080,
    double scale = 1,
    bool isMobile = false,
    bool hasTouch = false,
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
        executablePath: await getBrowserPath(),
        headless: !visible,
        devTools: devtools,
        defaultViewport: DeviceViewport(
            width: width,
            height: height,
            deviceScaleFactor: scale,
            isMobile: isMobile,
            hasTouch: hasTouch),
        args: [
          '--remote-debugging-port=9222',
        ],
        ignoreDefaultArgs: [
          '--remote-debugging-port=9222',
          '--disable-infobars',
          '--disable-extensions',
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
          '--disable-backgrounding-occluded-windows',
          '--disable-background-timer-throttling',
          '--disable-background-networking',
          '--disable-renderer-backgrounding',
        ],
        plugins: null,
        timeout: timeout ?? Duration(minutes: 10),
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
