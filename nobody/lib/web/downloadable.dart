import 'package:nobody/references.dart';

import 'any_downloadable.dart';
import 'any_path.dart';

/// DownloadableSapTable
class DownloadableSapTable implements AnyDownloadable {
  String get name => 'Table from SAP';
  const DownloadableSapTable();

  @override
  Future<Online> download(Online browser, AnyPath path) async {
    await browser.waitFor(Sap.TableHeader);
    //send Ctrl+Shift+F10 to window
    await browser.key_down(Key.control, show: false);
    await browser.key_down(Key.control, show: false);
    await browser.key_down(Key.shift, show: false);
    await browser.press(Key.f10, show: false);
    await browser.key_up(Key.control, show: false);
    await browser.key_up(Key.shift, show: false);
    await browser.click(
        Css('div[role="button"][title="Spreadsheet... (Ctrl+Shift+F7)"]'),
        show: false);
    await browser.click(Css('div[role="button"][title="Continue (Enter)"]'),
        show: false);
    await browser.set(Css('#popupDialogInputField'), 'table.xlsx', show: false);
    await browser.click(Css('#UpDownDialogChoose'), show: false);
    // await browser.waitFor(Waitable)
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
