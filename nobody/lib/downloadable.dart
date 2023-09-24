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
        .capture_download();
    return browser;
  }
}
