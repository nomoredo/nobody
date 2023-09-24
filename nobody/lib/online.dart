import 'references.dart';

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

  Future<Online> set_range(
    AbstractSelector selector,
    String from,
    String to, {
    Duration? timeout = null,
  }) async {
    var Online = await this;
    Show.action('SETTING', selector.selector, from, 'TO', to);
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

  //list
  //lists all elements matching the selector
  Future<Online> list(AbstractSelector selector) async {
    Show.action('LISTING', selector.selector);
    await (await page).waitForSelector(selector.selector);
    var elements = await (await page).evaluate('''(selector) => {
      //query all elements matching the selector
      var elements = document.querySelectorAll(selector);
      //get all properties of each element
      var elements_list = []
      for (var element of elements) {
        var element_properties = {};
       //get all attributes of the element
        for (var attribute of element.attributes) {
          if (attribute.name =='title' || attribute.name=='type' || attribute.name=='name' || attribute.name=='id' || attribute.name=='class') {
            element_properties[attribute.name] = attribute.value;
          }
        }
        
        elements_list[element.title] = element_properties;
      }
      return elements_list;

    }''', args: [selector.selector]);
    //colorize the elements
    Show.anything(elements);

    return this;
  }

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

  Future<Online> capture_download() async {
    var page = await this.page;
    //capture download and save it to test.xlsx
    // await page.browser.connection.send(
    //     'Page.setDownloadBehavior', {'behavior': 'allow', 'downloadPath': '.'});

//event listener for download
    var listner = await page.evaluateOnNewDocument('''() => {
      document.addEventListener('download', event => {
      // Extract url from event.detail.url
      // event.detail.url is the url of the downloaded file
      // event.detail.suggestedFilename is the filename suggested by the page
      // event.detail.mime is the mime type of the download
      // send all these information back to dart using cdp
      //call exposed function download
      download(event.detail);
    });
    }''');

    //listen for download event
    await page.exposeFunction('download', (Map<String, dynamic> data) async {
      print(data);
      //download the file
      // var response = awai
      // //save the file
      // await File(data['suggestedFilename']).writeAsBytes(response.bodyBytes);
    });
    return this;
  }
}

typedef Waitable<T> = Future<bool> Function(Online);

//lets define some waitables
//wait_for(Navigation)
Waitable UntilPageLoaded = (Online online) async {
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
