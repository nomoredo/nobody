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

  Future<Online> log_requests() async {
    //listen and log all requests and responses
    await (await page).onRequest.listen((request) async {
      print("REQUEST: ${request.method} ${request.url}");
      if (request.postData != null) {
        print("POST DATA: ${request.postData}");
      }
    });
    return this;
  }

  Future<Online> artificial_delay() async {
    await (await page).onRequest.listen((request) async {
      // print("REQUEST: ${request.method} ${request.url}");
      if (request.postData != null) {
        // print("POST DATA: ${request.postData}");
      }
    });
    return this;
  }

  Future<Online> log_clicks() async {
    //expose a function to javascript to log clicks
    await (await page).exposeFunction('log_click', (String element) {
      Show.action('clicked', element.toString(), '(LOGGED FROM JAVASCRIPT)');
    });

    //add event listeners to all elements to log clicks
    await (await page).evaluate(event_listner_code);

    print('ADDED EVENT LISTENERS FOR CLICKS');
    return this;
  }

  static String event_listner_code = '''() => {
      function calculateXPath(element) {
    if (element) {
        //often times we cannot use id because it may change on page refresh
        //since we are trying to get path to sap gui elements, we can use the id
        //since it is static
        if (element.id) {
            return `id('\${element.id}')`;
        }
        //if there is no id, we can use the class name of the element and its parent
        //to get the xpath
        if (element.className) {
            return calculateXPath(element.parentNode) + `/\${element.tagName.toLowerCase()}[@class="\${element.className}"]`;
        }
        //if there is no class name, we can use the tag name and parent to get the xpath
        return calculateXPath(element.parentNode) + `/\${element.tagName.toLowerCase()}`;
    }
    return 'null';
}

//add event listeners to all elements to log clicks
const elements = document.querySelectorAll('*');
for (const element of elements) {
    element.addEventListener('click', (event) => {
        const xpath = calculateXPath(event.target);
        window.log_click(xpath);
    });
}

    }''';

  Future<Online> log_responses() async {
    await (await page).onResponse.listen((response) async {
      print("RESPONSE: ${response.status} ${response.url}");
      if (response.request.postData != null) {
        print("POST DATA: ${response.request.postData}");
      }
    });
    return this;
  }

  Future<Online> login(Authable authable, {bool show = true}) async {
    if (show) Show.action('authenticating', authable.username);
    return await authable.login(this);
  }

  Future<Online> visit(String url, {bool show = true}) async {
    if (show) Show.action('visiting', url.clean_url());
    await (await page).goto(url, wait: Until.domContentLoaded);
    return this;
  }

  Future<Online> goto(AbstractUrl url, {bool show = true}) async {
    var clean_url = Uri.encodeFull(url.url);
    if (show) Show.action('visiting', clean_url.clean_url());
    await (await page).goto(clean_url, wait: Until.domContentLoaded);
    return this;
  }

  //navigate
  Future<Online> navigate(String url, {bool show = true}) async {
    // clean up url to make sure it is valid
    if (!url.startsWith('http')) {
      url = 'https://$url';
    }
    //handle # ? and other special characters
    url = Uri.encodeFull(url);

    if (show) Show.action('navigating to', url);
    await (await page).goto(url, wait: Until.load);
    return this;
  }

  Future<Online> set(AbstractSelector selector, String text,
      {bool show = true, Duration? timeout = null, int index = 0}) async {
    if (show) Show.action('set', 'value', text);
    if (selector is XPath) {
      var selected = await (await page).waitForXPath(selector.selector);
      if (selected != null) {
        await selected.evaluateHandle('''(element, text) => {
        element.focus(); // Focus on the element
        var inputEvent = new Event('input', {bubbles: true});
        var changeEvent = new Event('change', {bubbles: true});
        element.dispatchEvent(inputEvent);
        element.value = text;
        element.dispatchEvent(changeEvent);
        element.blur(); // Remove focus from the element

        }''', args: [text]);
      }
    } else {
      var selected = await (await page).waitForSelector(selector.selector);
      if (selected != null) {
        await selected.evaluateHandle('''(element, text) => {
        element.focus(); // Focus on the element
        var inputEvent = new Event('input', {bubbles: true});
        var changeEvent = new Event('change', {bubbles: true});
        element.dispatchEvent(inputEvent);
        element.value = text;
        element.dispatchEvent(changeEvent);
        element.blur(); // Remove focus from the element
        
        }''', args: [text]);
      }
    }
    return this;
  }

  Future<Online> set_secret(AbstractSelector selector, String text,
      {Duration? timeout = null, int index = 0}) async {
    Show.action('set', 'secret', text.obscure());
    if (selector is XPath) {
      var selected = await (await page).waitForXPath(selector.selector);
      if (selected != null) {
        await selected.evaluateHandle('''(element, text) => {
          element.value = text;
        }''', args: [text]);
      }
    } else {
      var selected = await (await page).waitForSelector(selector.selector);
      if (selected != null) {
        await selected.evaluateHandle('''(element, text) => {
          element.value = text;
        }''', args: [text]);
      }
    }
    return this;
  }

  Future<Online> set_range(AbstractSelector selector, String from, String to,
      {Duration? timeout = null, bool log = true}) async {
    var Online = await this;
    if (log) Show.action('set', selector.selector, from, 'to', to);
    await Online.set(selector, from, timeout: timeout, index: 0);
    await Online.set(selector, to, timeout: timeout, index: 1);
    return Online;
  }

  Future<Online> type(String selector, String text) async {
    Show.action('typing', text);
    await (await page).waitForSelector(selector);
    await (await page).type(selector, text);
    return this;
  }

  ///When / Then
  /// eg. wait for a context menu to appear and select the 'Spreadsheet' option from the context menu
  /// when(Css('div[role="menu"]'), (x) => x.click(Css('div[role="menu"]')))
  Future<Online> when(Waitable waitable, MapFunc<Online, dynamic> action,
      {Duration? timeout}) async {
    Show.action('when', waitable.toString());
    await waitable(this);
    await action(this);
    return this;
  }

  //ex
  // executes js and returns online
  // ex('document.querySelector("input").value = "$text";', text: 'hello world');
  Future<Online> ex(MapFunc<ElementHandle, dynamic> script,
      {List<dynamic>? args}) async {
    Show.action('executing', 'javascript\n', script.toString());
    await (await page).evaluate(script.toString(), args: args);
    return this;
  }

  //focus
  Future<Online> focus(AbstractSelector selector, {bool show = true}) async {
    if (show) Show.action('focusing', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).focus(selector.selector);
    return this;
  }

  //when_contains
  // finds he first div/span/p/li/ul/ol/a/h1/h2/h3/h4/h5/h6 with text containing the text
  //and executes the action on it
  //when_contains('hello world', (e) => e.click());
  Future<Online> when_contains(
    String selector,
    String text,
    MapFunc<ElementHandle, dynamic> action,
  ) async {
    Show.action('when', 'contains', text);
    var page = await this.page;
    await page.waitForSelector(selector);
    var element = await page.$eval(selector, '''(element, text) => {
      return Array.from(element.querySelectorAll('div,span,p,li,ul,ol,a,h1,h2,h3,h4,h5,h6')).find((e) => e.innerText.includes(text));
    }''', args: [text]);
    if (element != null) {
      await action(element);
    }
    return this;
  }

  //click
  Future<Online> click(AbstractSelector selector,
      {bool show = true, int index = 0}) async {
    if (show) Show.action('clicking', selector.selector);
    if (selector is XPath) {
      var selected =
          await (await page).waitForXPath(selector.selector, visible: true);
      if (selected != null) {
        await selected.click();
      }
    } else {
      var selected =
          await (await page).waitForSelector(selector.selector, visible: true);
      if (selected != null) {
        await selected.click();
      }
    }
    return this;
  }

  //press
  Future<Online> press(Key key, {bool show = true}) async {
    if (show) Show.action('pressing', key.toString());

    await (await page).keyboard.press(key);
    return this;
  }

  //submit form
  Future<Online> submit(AbstractSelector selector) async {
    Show.action('submitting', selector.selector);
    await (await page).waitForSelector(selector.selector, visible: true);
    await (await page).evaluate('''(selector) => {
      document.querySelector(selector).submit();
    }''', args: [selector.selector]);
    return this;
  }

  //select_frame that has a match for the selector
  Future<Online> select_frame(String selector) async {
    var frames = await (await page).frames;
    for (var frame in frames) {
      try {
        await (await frame).$eval(selector, '''(element) => {
          element.click();
        }''');
      } catch (e) {
        print(e);
      }
    }
    return this;
  }

  //download sap table
  Future<Online> downloadSapTable() async {
    await this.waitFor(Sap.TableHeader);
    //send Ctrl+Shift+F10 to window
    await (await page).keyboard.down(Key.control);
    await (await page).keyboard.down(Key.shift);
    await (await page).keyboard.press(Key.f10);
    await (await page).keyboard.up(Key.control);
    await (await page).keyboard.up(Key.shift);
    await this.click(
        Css('div[role="button"][title="Spreadsheet... (Ctrl+Shift+F7)"]'));
    await this.click(Css('div[role="button"][title="Continue (Enter)"]'));
    await this.set(Css('#popupDialogInputField'), 'table.xlsx');
    await this.click(Css('#UpDownDialogChoose'));

    return this;
  }

  //right click
  Future<Online> right_click(AbstractSelector selector) async {
    Show.action('right click', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).click(selector.selector, button: MouseButton.right);
    return this;
  }

  //click_on_context_menu_item
  Future<Online> click_on_context_menu_item(String text) async {
    Show.action('clicking', 'on context menu item', text);
    await (await page).waitForSelector('td.urMnuTxt');
    await (await page).evaluate('''(text) => {
      const element = Array.from(document.querySelectorAll('td.urMnuTxt')).find((e) => e.innerText.includes(text));
      element.click();
    }''', args: [text]);
    return this;
  }

  //double click
  Future<Online> double_click(AbstractSelector selector) async {
    Show.action('double click', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).click(selector.selector, clickCount: 2);
    return this;
  }

  //hover
  Future<Online> hover(AbstractSelector selector) async {
    Show.action('hover over', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).hover(selector.selector);
    return this;
  }

  //middle click
  Future<Online> middle_click(AbstractSelector selector) async {
    Show.action('middle click', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).click(selector.selector, button: MouseButton.middle);
    return this;
  }

  //key down
  Future<Online> key_down(Key key, {bool show = true}) async {
    if (show) Show.action('key down', key.toString());
    await (await page).keyboard.down(key);
    return this;
  }

  //key up
  Future<Online> key_up(Key key, {bool show = true}) async {
    if (show) Show.action('key up', key.toString());
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
    Show.action('closing', 'browser');
    await browser.close();
    return this;
  }

  Future<Online> screenshot(String path) async {
    Show.action('capture', 'screenshot', path);
    var sc = await (await page).screenshot();
    await File(path).writeAsBytes(sc);
    return this;
  }

  Future<Online> download(
      AbstractDownloadable downloadable, AbstractPath path) async {
    Show.action('downloading', downloadable.name);
    await downloadable.download(this, path);
    return this;
  }

  Future<Online> scrollToElement(AbstractSelector selector) async {
    Show.action('scrolling', 'to', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).evaluate('''(selector) => {
      document.querySelector(selector).scrollIntoView();
    }''', args: [selector.selector]);
    return this;
  }

  Future<Online> scrollBy(int x, int y) async {
    Show.action('scrolling', 'by', x.toString(), y.toString());
    await (await page).evaluate('''() => {
      window.scrollBy($x, $y);
    }''');
    return this;
  }

  Future<String?> get_value(AbstractSelector selector, String property) async {
    Show.action('getting', property, 'of', selector.selector);
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

  /// List elements matching the selector
  Future<Online> list_elements(AbstractSelector selector) async {
    Show.action('listing', selector.selector);
    await (await page).waitForSelector(selector.selector);
    var elements = await (await page).evaluate('''(selector) => {
      return Array.from(document.querySelectorAll(selector)).map((e) => {
        return e;
      });
    }''', args: [selector.selector]);
    Show.tree(elements, title: selector.selector);
    return this;
  }

  /// List inputs
  /// List all input elements and their attributes for the current page
  Future<Online> list_inputs() async {
    Show.action(
        'listing', 'input elements', 'in', (await page).url.clean_url());
    await (await page).waitForSelector('input');
    //return a list of all input elements each as a map of properties
    var elements = await (await page).evaluate('''() => {
      return Array.from(document.querySelectorAll('input')).map((e) => {
       // list all attributes and their values
        return Array.from(e.attributes).reduce((map, attribute) => {
          map[attribute.name] = attribute.value;
          return map;
        }, {});
      });
    }''');
    Show.tree(elements, title: "inputs");
    return this;
  }

  /// List textareas
  /// List all textarea elements and their attributes for the current page
  Future<Online> list_textareas() async {
    Show.action(
        'listing', 'textarea elements', 'in', (await page).url.clean_url());
    await (await page).waitForSelector('textarea');
    //return a list of all input elements each as a map of properties
    var elements = await (await page).evaluate('''() => {
      return Array.from(document.querySelectorAll('textarea')).map((e) => {
       // list all attributes and their values
        return Array.from(e.attributes).reduce((map, attribute) => {
          map[attribute.name] = attribute.value;
          return map;
        }, {});
      });
    }''');
    Show.tree(elements, title: "textareas");
    return this;
  }

  /// List buttons
  /// List all button elements and their attributes for the current page
  Future<Online> list_buttons() async {
    Show.action(
        'listing', 'button elements', 'in', (await page).url.clean_url());
    await (await page).waitForSelector('button');
    //return a list of all input elements each as a map of properties
    var elements = await (await page).evaluate('''() => {
      return Array.from(document.querySelectorAll('button')).map((e) => {
       // list all attributes and their values
        return Array.from(e.attributes).reduce((map, attribute) => {
          map[attribute.name] = attribute.value;
          return map;
        }, {});
      });
    }''');
    Show.tree(elements, title: "buttons");
    return this;
  }

  /// List clickable elements
  /// List all clickable elements and their attributes for the current page
  Future<Online> list_clickable() async {
    Show.action(
        'listing', 'clickable elements', 'in', (await page).url.clean_url());
    await (await page).waitForSelector('a');
    //return a list of all input elements each as a map of properties
    var elements = await (await page).evaluate('''() => {
      return Array.from(document.querySelectorAll('a')).map((e) => {
       // list all attributes and their values
        return Array.from(e.attributes).reduce((map, attribute) => {
          map[attribute.name] = attribute.value;
          return map;
        }, {});
      });
    }''');
    Show.tree(elements, title: "clickable");
    return this;
  }

  /// List dropdowns
  /// List all dropdown elements and their attributes for the current page
  Future<Online> list_dropdowns() async {
    Show.action(
        'listing', 'dropdown elements', 'in', (await page).url.clean_url());
    await (await page).waitForSelector('select');
    //return a list of all input elements each as a map of properties
    var elements = await (await page).evaluate('''() => {
      return Array.from(document.querySelectorAll('select')).map((e) => {
       // list all attributes and their values
        return Array.from(e.attributes).reduce((map, attribute) => {
          map[attribute.name] = attribute.value;
          return map;
        }, {});
      });
    }''');
    Show.tree(elements, title: "dropdowns");
    return this;
  }

  /// List checkboxes
  Future<Online> list_checkboxes() async {
    Show.action(
        'listing', 'checkbox elements', 'in', (await page).url.clean_url());
    await (await page).waitForSelector('input[type="checkbox"]');
    //return a list of all input elements each as a map of properties
    var elements = await (await page).evaluate('''() => {
      return Array.from(document.querySelectorAll('input[type="checkbox"]')).map((e) => {
       // list all attributes and their values
        return Array.from(e.attributes).reduce((map, attribute) => {
          map[attribute.name] = attribute.value;
          return map;
        }, {});
      });
    }''');
    Show.tree(elements, title: "checkboxes");
    return this;
  }

  /// List radio buttons
  Future<Online> list_radio_buttons() async {
    Show.action(
        'listing', 'radio button elements', 'in', (await page).url.clean_url());
    await (await page).waitForSelector('input[type="radio"]');
    //return a list of all input elements each as a map of properties
    var elements = await (await page).evaluate('''() => {
      return Array.from(document.querySelectorAll('input[type="radio"]')).map((e) => {
       // list all attributes and their values
        return Array.from(e.attributes).reduce((map, attribute) => {
          map[attribute.name] = attribute.value;
          return map;
        }, {});
      });
    }''');
    Show.tree(elements, title: "radio buttons");
    return this;
  }

  /// List images
  Future<Online> list_images() async {
    Show.action(
        'listing', 'image elements', 'in', (await page).url.clean_url());
    await (await page).waitForSelector('img');
    //return a list of all input elements each as a map of properties
    var elements = await (await page).evaluate('''() => {
      return Array.from(document.querySelectorAll('img')).map((e) => {
       // list all attributes and their values
        return Array.from(e.attributes).reduce((map, attribute) => {
          map[attribute.name] = attribute.value;
          return map;
        }, {});
      });
    }''');
    Show.tree(elements, title: "images");
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

UntilVisible(AbstractSelector selector) => (Online browser) async {
      await browser.evaluate('''(selector) => {
        //wait for selector to be visible
        return new Promise((resolve, reject) => {
          const interval = setInterval(() => {
            const element = document.querySelector(selector);
            if (element) {
              clearInterval(interval);
              resolve(true);
            }
          }, 500);
        });
      }''', args: [selector.selector]);

      return true;
    };
