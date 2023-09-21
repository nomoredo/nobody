import 'package:codegen/codegen.dart';
import 'package:collection/collection.dart';
import 'package:nobody/input.dart';
import 'package:nobody/nobody.dart';
import 'package:nobody/sap.dart';
import 'package:puppeteer/puppeteer.dart';

export 'input.dart';
export 'nobody.dart';

@NomoCode()
class Transaction {
  final SapWebUi inner;
  final Online online;
  late final Page page;
  Map<String, Input>? _fields;

  static const inputSelector = "[name='InputField'][class='lsField__input']";
  static const multiButtonSelector = "div[title='Multiple selection']";
  static const executeButtonSelector = "div[title='Execute (F8)']";
  static const tableSelector = "table[role='grid']";
  static const tableCtxSpreadsheetsSelector =
      "xpath=/html/body/table/tbody/tr/td/div/div/div[1]/div[9]/span/div/div[5]/table/tbody/tr[10]/td[3]/span";
  static const popupWindowSelector =
      "div[class='urPWOuterBorder lsPopupWindow lsPopupWindow--dialog lsPWShadowStd lsScope--s']";
  static const popupExecuteButtonSelector =
      "xpath=/html/body/table/tbody/tr/td/div/div/div[1]/div[11]/div/div/div[4]/div/table/tbody/tr/td[3]/div/div/div/div[1]/span[2]/div";
  static const popupFileNameInput =
      "xpath=/html/body/table/tbody/tr/td/div/div/div[3]/div/div[3]/table/tbody/tr/td/div/table/tbody/tr[1]/td[2]/table/tbody/tr/td/input";
  static const popupFileNameConfirmButton =
      "xpath=/html/body/table/tbody/tr/td/div/div/div[3]/div/div[4]/div/table/tbody/tr/td[3]/table/tbody/tr/td[1]/div";

  Transaction(this.inner, this.online) {
    page = inner.inner.page;
  }

  Future<void> initialize() async {
    print("TRANSACTION OVERVIEW");

    var input_handles = await page.$$(inputSelector);
    var multi_button_handles = await page.$$(multiButtonSelector);

    var inputs =
        groupBy(input_handles, (e) => e.propertyValue('title').toString());
    var multi_index = 0;
    for (var input in inputs.entries) {
      if (input.value.length > 1) {
        print("MULTI BUTTON ${input.key}");
        _fields![input.key] = Input(input.key, input.value[0], input.value[1],
            multi_button_handles[multi_index++]);
      } else {
        print("INPUT ${input.key}");
        _fields![input.key] = Input(input.key, input.value[0], null, null);
      }
    }

    print("Divider");
  }

  Future<Map<String, Input>> fields() async {
    if (_fields == null) {
      await initialize();
    }
    return _fields!;
  }

  Future<Transaction> waitFor(Waitable waitable) async {
    await waitable(online);
    return this;
  }

  Future<Transaction> set(String label, String value) async {
    if (_fields != null && _fields!.containsKey(label)) {
      print("SETTING FIELD $label $value");
      await _fields![label]!.handle.type(value);
    } else {
      print("FIELD NOT FOUND $label");
    }
    return this;
  }

  Future<Transaction> execute() async {
    await page.click(executeButtonSelector);
    return this;
  }

  Future<Transaction> export(String path) async {
    var table = await page.$(tableSelector);
    await table.click(button: MouseButton.right);
    await page.click(tableCtxSpreadsheetsSelector);
    await page.waitForSelector(popupWindowSelector);
    await page.click(popupExecuteButtonSelector);
    await page.waitForSelector(popupFileNameInput);
    await page.type(popupFileNameInput, path);
    await page.click(popupFileNameConfirmButton);
    await waitForDownload(path);
    return this;
  }

  Future<Transaction> waitForDownload(String path, [int timeout = 5]) async {
    await page.waitForDownload(timeout: Duration(minutes: timeout));
    return this;
  }

  Future<Transaction> setRange(String label, String from, String to) async {
    var field = _fields![label];
    await field?.handle.type(from);
    if (field?.maxHandle != null) {
      await field?.maxHandle?.type(to);
    }
    return this;
  }

  Future<Transaction> clear(String label) async {
    var field = _fields![label];
    await field?.handle.type('');
    return this;
  }

  Future<Transaction> sets(String label, List<String> values) async {
    if (_fields != null && _fields!.containsKey(label)) {
      var field = _fields![label];
      await field?.multiButton?.click();
      await page.waitForSelector("div[ct='PW'][role='dialog']",
          timeout: Duration(minutes: 5));
      var popupWindow = await page.$("div[ct='PW'][role='dialog']");
      var rows =
          await popupWindow.$$("td[role='gridcell'][lsmatrixcolindex='1']");

      for (int i = 0; i < values.length; i++) {
        var row = rows[i];
        await row.click();
        var input =
            await row.$("input[name='InputField'][class='lsField__input']");
        await input.type(values[i]);
        await page.keyboard.press(Key.arrowDown);
      }

      await popupWindow
          .$("div[title='Copy (F8)']")
          .then((value) => value.click());
    } else {
      print("FIELD NOT FOUND $label");
    }
    return this;
  }

  Future<Transaction> wait(Duration timeSpan) async {
    await Future.delayed(timeSpan);
    return this;
  }

  Future<Transaction> listTables() async {
    var tables = await page.$$(tableSelector);
    for (var table in tables) {
      print("TABLE ${await table.propertyValue('title')}");
    }
    return this;
  }

  Future<Transaction> exportTable(String path, [int timeout = 5]) async {
    await page.waitForSelector(tableSelector,
        timeout: Duration(minutes: timeout));
    await page.click(tableSelector, button: MouseButton.right);
    await page.click(tableCtxSpreadsheetsSelector);
    await page.click(popupExecuteButtonSelector);
    await page.type(popupFileNameInput, path);
    await page.click(popupFileNameConfirmButton);
    await Future.delayed(Duration(seconds: 100));
    return this;
  }

  Future<Transaction> listenDownloads() async {
    page.browser.onTargetCreated.listen((target) async {
      if (target.type == "page") {
        var page = await target.page;
        var contentDisposition = await page.evaluate(
            "() => document.querySelector('meta[http-equiv=\"Content-Disposition\"]')?.content");
        if (contentDisposition != null &&
            contentDisposition.startsWith('attachment')) {
          var downloadUrl = page.url;
          // Handle the download URL as needed
          print("Download triggered from URL: $downloadUrl");
        }
      }
    });
    return this;
  }
}
