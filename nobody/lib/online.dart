import 'references.dart';

@NomoCode()
class Online {
  Future<Page> get page => lastPage();
  final Browser browser;

  Online(this.browser);

  Future<Page> lastPage() async {
    var pages = await browser.pages;
    return pages.last;
  }

  Future<Online> login(Authable authable) async {
    Show.action('LOGGING IN', authable.username);
    return await authable.login(this);
  }

  Future<Online> visit(String url) async {
    Show.action('VISITING', url);
    await (await page).goto(url, wait: Until.load);
    return this;
  }

  Future<Online> goto(AbstractUrl url) async {
    Show.action('VISITING', url.url);
    await (await page).goto(url.url, wait: Until.load);
    return this;
  }

  Future<Online> set(AbsractSelector selector, String text) async {
    Show.action('SETTING', text);
    await (await page).waitForSelector(selector.selector);
    await (await page)
        .$eval(selector.selector, 'e => e.value = "$text"', args: [text]);
    return this;
  }

  Future<Online> type(String selector, String text) async {
    Show.action('TYPING', text);
    await (await page).waitForSelector(selector);
    await (await page).type(selector, text);
    return this;
  }

  Future<Online> click(AbsractSelector selector) async {
    Show.action('CLICKING', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).click(selector.selector);
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

  Future<Online> close() async {
    Show.action('CLOSING', 'BROWSER');
    await browser.close();
    return this;
  }

  Future<Online> screenshot(String path) async {
    Show.action('TAKING SCREENSHOT', path);
    var sc = await (await page).screenshot();
    await File(path).writeAsBytes(sc);
    return this;
  }

  Future<Online> scrollToElement(AbsractSelector selector) async {
    Show.action('SCROLLING TO', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).evaluate('''(selector) => {
      document.querySelector(selector).scrollIntoView();
    }''', args: [selector.selector]);
    return this;
  }

  Future<Online> scrollBy(int x, int y) async {
    Show.action('SCROLLING BY', 'x: $x, y: $y');
    await (await page).evaluate('''() => {
      window.scrollBy($x, $y);
    }''');
    return this;
  }

  Future<String?> get_value(AbsractSelector selector, String property) async {
    Show.action('GETTING VALUE', property);
    await (await page).waitForSelector(selector.selector);
    var value = await (await page).evaluate('''(selector, property) => {
      return document.querySelector(selector).$property;
    }''', args: [selector.selector, property]);
    return value;
  }

  Future<dynamic> evaluate(String script) async {
    Show.action('EVALUATING JAVASCRIPT', script);
    return await (await page).evaluate(script);
  }

  Future<List<Page>> pages() async {
    return await browser.pages;
  }

  Future<Page> newPage() async {
    return await browser.newPage();
  }

  Future<Page> get_page(int index) async {
    var pages = await browser.pages;
    return pages[index];
  }

  Future<Online> close_page(int index) async {
    var pages = await browser.pages;
    if (pages.length > index) {
      await pages[index].close();
    }
    return this;
  }

  Future<Online> close_all_pages() async {
    var pages = await browser.pages;
    for (var page in pages) {
      await (await page).close();
    }
    return this;
  }

  Future<Online> close_all_other_pages() async {
    while ((await browser.pages).length > 1) {
      await close_page(1);
    }
    return this;
  }
}

typedef Waitable<T> = Future<bool> Function(Online);

//lets define some waitables
//wait_for(Navigation)
Waitable Navigation = (Online online) async {
  Show.action('WAITING', 'FOR', "NAVIGATION");
  await (await online.page).waitForNavigation();
  return true;
};

Waitable PageLoad = (Online online) async {
  Show.action('WAITING', 'FOR', "PAGE LOAD");
  await (await online.page).waitForNavigation();
  return true;
};

Waitable Seconds(int seconds) => (Online online) async {
      Show.action('WAITING', 'FOR', seconds.toString(), 'SECONDS');
      await Future.delayed(Duration(seconds: seconds));
      return true;
    };

Waitable Element(String selector) => (Online online) async {
      Show.action('WAITING', 'FOR', selector);
      await (await online.page).waitForSelector(selector);
      return true;
    };
