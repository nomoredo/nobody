import 'package:codegen/codegen.dart';
import 'package:puppeteer/puppeteer.dart';

class Nobody {
  static Future<Online> online({bool visible = true}) async {
    var browser = await puppeteer.launch(headless: !visible);
    var page = await browser.newPage();
    return Online(browser, page);
  }
}

@NomoCode()
class Online {
  final Browser _browser;
  final Page _page;

  Online(this._browser, this._page);

  Future<Online> visit(String url) async {
    await _page.goto(url);
    return this;
  }

  Future<Online> type(String selector, String text) async {
    await _page.type(selector, text);
    return this;
  }

  Future<Online> click(String selector) async {
    await _page.click(selector);
    return this;
  }

  Future<Online> waitFor(String selector) async {
    await _page.waitForSelector(selector);
    return this;
  }

  Future<Online> has(String selector, String text) async {
    var element = await _page.$(selector);
    var elementText = await _page
        .evaluate('(element) => element.textContent', args: [element]);
    if (elementText != text) {
      throw Exception(
          'Expected $selector to have text $text, but found $elementText');
    }
    return this;
  }

  Future<Online> close() async {
    await _browser.close();
    return this;
  }
}

// extension ExOnline on Future<Online> {
//   Future<Online> visit(String url) async {
//     var online = await this;
//     return online.visit(url);
//   }

//   Future<Online> type(String selector, String text) async {
//     var online = await this;
//     return online.type(selector, text);
//   }

//   Future<Online> click(String selector) async {
//     var online = await this;
//     return online.click(selector);
//   }

//   Future<Online> waitFor(String selector) async {
//     var online = await this;
//     return online.waitFor(selector);
//   }

//   Future<Online> has(String selector, String text) async {
//     var online = await this;
//     return online.has(selector, text);
//   }

//   Future<Online> close() async {
//     var online = await this;
//     return online.close();
//   }
// }
