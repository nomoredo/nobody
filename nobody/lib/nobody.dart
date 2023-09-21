import 'dart:io';

import 'package:codegen/codegen.dart';
import 'package:nobody/sap.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:termo/termo.dart';

class Nobody {
  static Future<Online> online({bool visible = true, bool slow = false}) async {
    var browser = await puppeteer.launch(
        headless: !visible,
        noSandboxFlag: true,
        slowMo: Duration(milliseconds: slow ? 1000 : 0));
    var page = await browser.newPage();
    return Online(page);
  }

  static Future<SapWebUi> sap(
      {bool visible = true,
      String? url,
      required String username,
      String? password,
      slow = false}) async {
    var inner = await online(visible: visible, slow: slow);
    return await SapWebUi.Login(inner, username);
  }
}

@NomoCode()
class Online {
  final Page page;
  Browser get browser => page.browser;

  Online(this.page);

  Future<Online> visit(String url) async {
    Show.action('VISITING', url);
    await page.goto(url, wait: Until.load);
    return this;
  }

  Future<Online> type(String selector, String text) async {
    Show.action('TYPING', text);
    await page.waitForSelector(selector);
    await page.type(selector, text);
    return this;
  }

  Future<Online> set(String selector, String text) async {
    Show.action('SETTING', text);
    await page.waitForSelector(selector);
    await page.$eval(selector, 'e => e.value = "$text"', args: [text]);

    return this;
  }

  Future<Online> click(String selector) async {
    Show.action('CLICKING', selector);
    var element = selector.startsWith('/')
        ? await page.waitForXPath(selector)
        : await page.waitForSelector(selector);
    await element?.click();
    return this;
  }

  //wait for should support:
  //wait_for(20.seconds)
  //wait_for('h3.LC20lb')
  //wait_for(Navigation)
  //uses Wait type
  Future<Online> waitFor(Waitable waitable) async {
    await waitable(this);
    return this;
  }

  Future<bool> has(String selector, String text) async {
    Show.action('CHECKING', 'IF', 'PAGE', 'HAS', text);
    var element = await page.$(selector);
    var elementText = await page
        .evaluate('(element) => element.textContent', args: [element]);
    return elementText != text;
  }

  Future<Online> close() async {
    Show.action('CLOSING', 'BROWSER');
    await browser.close();
    return this;
  }

  Future<Online> screenshot(String path) async {
    Show.action('TAKING SCREENSHOT', path);
    var sc = await page.screenshot();
    await File(path).writeAsBytes(sc);
    return this;
  }

  Future<Online> scrollToElement(String selector) async {
    Show.action('SCROLLING TO ELEMENT', selector);
    var element = await page.$(selector);
    await page.evaluate('''(element) => {
      element.scrollIntoView();
    }''', args: [element]);

    return this;
  }

  Future<Online> scrollBy(int x, int y) async {
    Show.action('SCROLLING BY', 'x: $x, y: $y');
    await page.evaluate('''() => {
      window.scrollBy($x, $y);
    }''');
    return this;
  }

  Future<String?> extractData(String selector, String attribute) async {
    Show.action('EXTRACTING DATA', 'from: $selector, attribute: $attribute');
    var element = await page.$(selector);
    return await element.propertyValue(attribute);
  }

  Future<Online> switchToFrame(String selector) async {
    Show.action('SWITCHING TO FRAME', selector);
    var frameElement = await page.$(selector);
    var frame = await this.page.evaluate('''(frameElement) => {
      return frameElement.contentWindow;
    }''', args: [frameElement]);

    await page.evaluate('''(frame) => {
      window = frame;
    }''', args: [frame]);
    return this;
  }

  Future<dynamic> evaluate(String script) async {
    Show.action('EVALUATING JAVASCRIPT', script);
    return await page.evaluate(script);
  }
}

typedef Waitable<T> = Future<bool> Function(Online);

//lets define some waitables
//wait_for(Navigation)
Waitable Navigation = (Online online) async {
  Show.action('WAITING', 'FOR', "NAVIGATION");
  await online.page.waitForNavigation();
  return true;
};

Waitable PageLoad = (Online online) async {
  Show.action('WAITING', 'FOR', "PAGE LOAD");
  await online.page.waitForNavigation();
  return true;
};

Waitable Seconds(int seconds) => (Online online) async {
      Show.action('WAITING', 'FOR', seconds.toString(), 'SECONDS');
      await Future.delayed(Duration(seconds: seconds));
      return true;
    };

Waitable Element(String selector) => (Online online) async {
      Show.action('WAITING', 'FOR', selector);
      await online.page.waitForSelector(selector);
      return true;
    };
