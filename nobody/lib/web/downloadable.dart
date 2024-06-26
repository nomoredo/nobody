import 'package:nobody/references.dart';

/// AbstractDownloadable
/// has a download method
abstract class AbstractDownloadable {
  String get name;
  Future<Online> download(Online browser, AbstractPath path);
}

/// DownloadableSapTable
class DownloadableSapTable implements AbstractDownloadable {
  String get name => 'Table from SAP';
  const DownloadableSapTable();

  @override
  Future<Online> download(Online browser, AbstractPath path) async {
    await browser.waitFor(Sap.TableHeader);

    try {
      // Send Ctrl+Shift+F10 to window
      await browser.key_down(Key.control, show: false);
      await browser.key_down(Key.shift, show: false);
      await browser.press(Key.f10, show: false);
      await browser.key_up(Key.control, show: false);
      await browser.key_up(Key.shift, show: false);
      // Attempt to click "Spreadsheet... (Ctrl+Shift+F7)" button
      await browser.click(
          Css('div[role="button"][title="Spreadsheet... (Ctrl+Shift+F7)"]'),
          show: false);
      await browser.click(Css('div[role="button"][title="Continue (Enter)"]'),
          show: false);
    } catch (e) {
      // If the initial click fails, attempt redundancy: Send Ctrl+Shift+F7 to window
      await browser.key_down(Key.control, show: false);
      await browser.key_down(Key.shift, show: false);
      await browser.press(Key.f7, show: false);
      await browser.key_up(Key.control, show: false);
      await browser.key_up(Key.shift, show: false);

      // Retry clicking the button after redundancy
      await browser.click(
          Css('div[role="button"][title="Spreadsheet... (Ctrl+Shift+F7)"]'),
          show: false);
      await browser.click(Css('div[role="button"][title="Continue (Enter)"]'),
          show: false);
    }

    // Click "aria/File Name" input field
    await browser.waitFor(Css('input#popupDialogInputField'));
    await browser.click(Css('input#popupDialogInputField'), show: true);

    // Clear and send the file name to the input field
    await browser.clear_value(Css('input#popupDialogInputField'), show: false);
    await browser.type(Css('input#popupDialogInputField'), await path.path,
        show: true);

    // Click the "Choose" button to confirm
    await browser.click(Css('#UpDownDialogChoose'), show: false);

    // Wait for download to complete
    return browser;
  }
}

/// DownloadableSap Table by right click on table header and selecting "Spreadsheet..." on context menu
class DownloadableSapTable2 implements AbstractDownloadable {
  String get name => 'Table from SAP';
  const DownloadableSapTable2();

  @override
  Future<Online> download(Online browser, AbstractPath path) async {
    await browser.waitFor(Sap.TableHeader);
    await browser.right_click(Sap.TableHeader, show: false);
    //select "Spreadsheet..." from context menu
    await browser.click(
        Sap.Data("wnd[0]/usr/cntlGRID1/shellcont/shell/mnu/menu&XXL"),
        show: false);

    await browser.click(Css('div[role="button"][title="Continue (Enter)"]'),
        show: false);
    await browser.waitFor(Css('input#popupDialogInputField'));
    await browser.click(Css('input#popupDialogInputField'), show: true);
    await browser.clear_value(Css('input#popupDialogInputField'), show: false);
    await browser.type(Css('input#popupDialogInputField'), await path.path,
        show: true);
    await browser.click(Css('#UpDownDialogChoose'), show: false);
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
