import '../references.dart';

@NomoCode()
class Online {
  Future<Page> get page => lastPage();
  final Browser browser;
  final Duration? default_timeout;

  Online(this.browser, {this.default_timeout});

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

  Future<Online> set(AbstractSelector selector, String text,
      {Duration? timeout = null, bool log = true, int index = 0}) async {
    if (log) Show.action('SETTING', text);
    await (await page).waitForSelector(selector.selector,
        timeout: timeout ?? default_timeout);
    await (await page).evaluate('''(selector, text, index) => {
      document.querySelectorAll(selector)[index].value = text;
    }''', args: [selector.selector, text, index]);
    return this;
  }

  Future<Online> set_range(AbstractSelector selector, String from, String to,
      {Duration? timeout = null, bool log = true}) async {
    var Online = await this;
    if (log) Show.action('SETTING', selector.selector, from, 'TO', to);
    await Online.set(selector, from, timeout: timeout, log: false, index: 0);
    await Online.set(selector, to, timeout: timeout, log: false, index: 1);
    return Online;
  }

  Future<Online> type(String selector, String text) async {
    Show.action('TYPING', text);
    await (await page).waitForSelector(selector);
    await (await page).type(selector, text);
    return this;
  }

  //click
  Future<Online> click(AbstractSelector selector) async {
    Show.action('CLICKING', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).click(selector.selector);
    return this;
  }

  //right click
  Future<Online> right_click(AbstractSelector selector) async {
    Show.action('RIGHT CLICKING', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).click(selector.selector, button: MouseButton.right);
    return this;
  }

  //double click
  Future<Online> double_click(AbstractSelector selector) async {
    Show.action('DOUBLE CLICKING', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).click(selector.selector, clickCount: 2);
    return this;
  }

  //hover
  Future<Online> hover(AbstractSelector selector) async {
    Show.action('HOVERING', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).hover(selector.selector);
    return this;
  }

  //middle click
  Future<Online> middle_click(AbstractSelector selector) async {
    Show.action('MIDDLE CLICKING', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).click(selector.selector, button: MouseButton.middle);
    return this;
  }

  //key down
  Future<Online> key_down(Key key) async {
    Show.action('KEY DOWN', key.toString());
    await (await page).keyboard.down(key);
    return this;
  }

  //key up
  Future<Online> key_up(Key key) async {
    Show.action('KEY UP', key.toString());
    await (await page).keyboard.up(key);
    return this;
  }

  Future<Online> fill(Map<String, dynamic> map,
      {AbstractSelector? form}) async {
    try {
      form ??= Css('#webguiform0');
      var pageInstance = await page;
      var selected = await pageInstance.waitForSelector(form.selector);
      if (selected != null) {
        var inputs = await selected.evaluate('''(form) => {
          return Array.from(form.querySelectorAll('input')).map((e) => e);
        }''');
        print(inputs);
      }
      // Assume Online is a class, and it has a constructor that can be called without arguments
      return this;
    } catch (e) {
      print('Error: $e');
      // Handle error or rethrow
      rethrow;
    }
  }

  //wait for should support:
  //wait_for(20.seconds)
  //wait_for('h3.LC20lb')
  //wait_for(Navigation)
  //uses Wait type
  Future<Online> waitFor(AbstractSelector waitable, {Duration? timeout}) async {
    await (await page).waitForSelector(waitable.selector,
        timeout: timeout ?? default_timeout);
    return this;
  }

  Future<Online> wait(Waitable waitable) async {
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

  Future<Online> download(
      AbstractDownloadable downloadable, AbstractPath path) async {
    Show.action('DOWNLOADING', downloadable.name);
    await downloadable.download(this, path);
    return this;
  }

  Future<Online> scrollToElement(AbstractSelector selector) async {
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

  Future<String?> get_value(AbstractSelector selector, String property) async {
    Show.action('GETTING VALUE', property);
    await (await page).waitForSelector(selector.selector);
    var value = await (await page).evaluate('''(selector, property) => {
      return document.querySelector(selector).$property;
    }''', args: [selector.selector, property]);
    return value;
  }

  Future<dynamic> evaluate(String script,
      {List<dynamic>? properties, List<dynamic>? args}) async {
    Show.action('EVALUATING', 'JAVASCRIPT\n', script);
    return await (await page).evaluate(script, args: args);
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

  //lists all elements matching the selector
  // all input fields have class containing 'lsField__input'
  // all buttons have class containing 'lsButton'
  // all dropdowns have class containing 'lsField__input' and aria-roledescription="Select"
  Future<Online> list_all(AbstractSelector selector) async {
    Show.action('LISTING', selector.selector);
    await (await page).waitForSelector(selector.selector);
    var elements = await (await page).evaluate('''(selector) => {
      return Array.from(document.querySelectorAll(selector)).map((e) => e.outerHTML);
    }''', args: [selector.selector]);
    Show.anything(elements);
    return this;
  }

  //lists all elements matching the selector
  Future<Online> send_hotkey(Key key, {List<Key>? modifiers}) async {
    if (modifiers != null) {
      for (var modifier in modifiers) {
        await (await page).keyboard.down(modifier);
      }
      await Future.delayed(Duration(milliseconds: 200));
      await (await page).keyboard.press(key);
      await Future.delayed(Duration(milliseconds: 200));

      for (var modifier in modifiers) {
        await (await page).keyboard.up(modifier);
      }
    } else {
      await (await page).keyboard.press(key);
    }

    return this;
  }
}

typedef MapFunc<T, R> = R Function(T);
typedef AsyncMapFunc<T, R> = Future<R> Function(T);
typedef MapManyFunc<T, R> = Iterable<R> Function(T);
typedef AsyncMapManyFunc<T, R> = Future<Iterable<R>> Function(T);
typedef Waitable<T> = Future<bool> Function(Online);

extension OnlineMapEx on Online {
  /// map
  /// maps the elements matching the selector to a list of type R
  /// to allow continuous chaining of methods, the return type is Online
  /// to still allow access to the list of type R, the list is stored in the
  /// out parameter can be accessed using the out parameter
  /// if you just want to perform an action on the list, you can use the
  /// transform parameter to perform the action
  /// example:
  /// var Online = await Nobody.online();
  /// var list = <String>[];
  /// await Online.map<String>(Css('h3.LC20lb'),(e) => e.text, ,out: list, transform: (list) => list.forEach(print));
  /// print(list);
  /// notice that out parameter is not required. if you dont need the list, you can just use the transform parameter
  /// similarly, if you dont need to perform an action on the list, you can just use the out parameter
  Future<Online> map<T, R>(AbstractSelector selector, MapFunc<T, R> mapFunc,
      {List<R>? out,
      MapManyFunc<T, R>? mapManyFunc,
      MapFunc<T, R>? transform}) async {
    Show.action('MAPPING', selector.selector);
    await (await page).waitForSelector(selector.selector);
    //execute javascript to get the elements matching the selector and return all their attributes and values as a list
    var elements = await (await page).evaluate('''(selector) => {
      return Array.from(document.querySelectorAll(selector)).map((e) => e);
    }''', args: [selector.selector]);
    var list = elements.map((e) => mapFunc(e as T)).toList();
    if (out != null) {
      out.addAll(list);
    }
    if (mapManyFunc != null) {
      var many = list.map((e) => mapManyFunc(e)).toList();
      if (out != null) {
        out.addAll(many);
      }
    }
    if (transform != null) {
      transform(list);
    }
    return this;
  }
}

extension OnlineMapAsyncEx on Future<Online> {
  Future<Online> map<T, R>(AbstractSelector selector, MapFunc<T, R> mapFunc,
      {List<R>? out,
      MapManyFunc<T, R>? mapManyFunc,
      MapFunc<T, R>? transform}) async {
    var Online = await this;
    await Online.map<T, R>(selector, mapFunc,
        out: out, mapManyFunc: mapManyFunc, transform: transform);
    return Online;
  }
}
