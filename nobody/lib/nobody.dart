import 'references.dart';

const APP_SECRET = "QKr8Q~ZvViURbcgL60Tqd3MsyMXKqBPACX4K4dAt";
const APP_ID = "376877d4-f7ea-4c45-bdc8-1c592ac38a9d";
const TENANT_ID = "bad285a0-eef3-4865-9a2c-7893068e70b0";

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
