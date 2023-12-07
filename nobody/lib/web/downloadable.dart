import 'package:nobody/references.dart';

/// AbstractDownloadable
/// has a download method
abstract class AbstractDownloadable {
  String get name;
  Future<Online> download(Online browser, AbstractPath path);
}

/// DownloadableSapTable
class DownloadableSapTable implements AbstractDownloadable {
  String get name => 'SAP TABLE';
  const DownloadableSapTable();

  @override
  Future<Online> download(Online browser, AbstractPath path) async {
    var table = SapTableHead();
    var tablePath = await path.path;
    await browser
        .waitFor(table)
        .send_hotkey(Key.f7, modifiers: [Key.control, Key.shift])
        .click(Css('div[role="button"][title="Continue (Enter)"]'))
        .set(Css('input[name="popupDialogInputField"]'), tablePath)
        .click(Css('div[id="UpDownDialogChoose"]'))
        .listen_for_downloads();
    return browser;
  }
}

extension ExDownload on Future<Online> {
  Future<Online> listen_for_downloads() async {
    var browser = await this;
    await (await browser.page).onRequest.listen((request) async {
      if (request.url.contains('EXPORT.XLSX')) {
        var response = await request.response;
        await (await browser.page).onResponse.listen((response) async {
          //capture octet stream and save to file
          var data = await response.content?.asStream().drain();
          await File('example.xlsx').writeAsBytes(data);
        });
      }
    });

    return browser;
  }
}
