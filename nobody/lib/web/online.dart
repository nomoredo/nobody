import '../references.dart';

typedef SelectorBuilder = AbstractSelector Function(int line, int column);
typedef SelectorFunc = Future Function(AbstractSelector selector);

@NomoCode()
class Online {
  Future<Page> get page => lastPage();
  final Browser browser;
  final Duration? default_timeout;
  final Duration minimal_timeout;

  Online(this.browser,
      {this.default_timeout,
      this.minimal_timeout = const Duration(milliseconds: 500)});

  Future<Page> lastPage() async {
    var pages = await browser.pages;
    if (pages.length > 0) {
      return pages.last;
    } else {
      return await browser.newPage();
    }
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

  /// log actions
  /// logs all user actions like clicks, typing, scrolling, etc in a structured format
  /// so that we can use it to write automation scripts
  Future<Online> log_actions() async {
    await (await page).exposeFunction('log_action', (String action, target) {
      Show.user_action(action, target);
    });

    //create a listener for all user actions and redirect them to the log_action function
    await (await page).evaluateOnNewDocument('''() => {
      document.addEventListener('click', (e) => {
        window.log_action('click', e.target);
      });
      document.addEventListener('contextmenu', (e) => {
        window.log_action('right click', e.target);
      });
      document.addEventListener('dblclick', (e) => {
        window.log_action('double click', e.target);
      });
      document.addEventListener('mouseover', (e) => {
        window.log_action('hover', e.target);
      });
      document.addEventListener('mousedown', (e) => {
        window.log_action('mouse down', e.target);
      });
      document.addEventListener('mouseup', (e) => {
        window.log_action('mouse up', e.target);
      });
      document.addEventListener('keydown', (e) => {
        window.log_action('key down', e.target);
      });
      document.addEventListener('keyup', (e) => {
        window.log_action('key up', e.target);
      });
      document.addEventListener('scroll', (e) => {
        window.log_action('scroll', e.target);
      });
      document.addEventListener('input', (e) => {
        window.log_action('input', e.target);
      });
      document.addEventListener('change', (e) => {
        window.log_action('change', e.target);
      });
    }''');
    return this;
  }

  Future<Online> login(Authable authable, {bool show = true}) async {
    if (await authable.is_logged_in(this)) {
      // if (show) Show.success("user is already logged in");
      return this;
    } else {
      if (show) Show.authenticating(authable);
      await (await page).goto("https://google.com");
      return await authable.login(this);
    }
  }

  Future<bool> has(AbstractSelector selector) async {
    try {
      var selected = await (await page).$(selector.selector);
      return selected != null;
    } catch (e) {
      return false;
    }
  }

  Future<Online> press_keyboard_shortcut(Key key,
      {List<Key> modifiers = const []}) async {
    var keys = modifiers.map((e) => e.toString()).join('+');
    Show.action('pressing', '$keys+$key');
    await (await page).keyboard.down(key);
    for (var modifier in modifiers) {
      await (await page).keyboard.down(modifier);
    }
    await (await page).keyboard.press(key);
    for (var modifier in modifiers) {
      await (await page).keyboard.up(modifier);
    }
    await (await page).keyboard.up(key);
    return this;
  }

  Future<Online> visit(String url, {bool show = true}) async {
    if (show) Show.visiting(url);
    await (await page).goto(url, wait: Until.domContentLoaded);
    return this;
  }

  Future<bool> has_cookie(String domain, String cookie) async {
    final cookie_func = (await (await page).cookies);
    final cookies = await cookie_func(urls: [domain]);
    return cookies.any((element) => element.name == cookie);
  }

  Future<Online> goto(AbstractUrl url, {bool show = true}) async {
    var clean_url = Uri.encodeFull(url.url);
    if (show) Show.visiting(clean_url);
    await (await page).goto(clean_url, wait: Until.domContentLoaded);
    return this;
  }

  //new tab
  Future<Online> new_tab(AbstractUrl url, {bool show = true}) async {
    if (show) Show.action('opening', 'new tab');
    final p = await (await browser).newPage();
    await p.goto(url.url, wait: Until.domContentLoaded);
    return this;
  }

  //scan
  Future<Online> scan(AbstractSelector selector, Function(ElementHandle) action,
      {bool show = true}) async {
    if (show) Show.scanning(selector.selector);
    // find out all the elements that match the selector
    var elements = await (await page).$$(selector.selector);
    for (var element in elements) {
      await action(element);
    }

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

    if (show) Show.visiting(url);
    await (await page).goto(url, wait: Until.load);
    return this;
  }

  Future<Online> set(AbstractSelector selector, Object? obj,
      {Object? max = null,
      bool show = true,
      Duration? timeout = null,
      int index = 0,
      bool click = false}) async {
    String text = obj?.toString() ?? '';
    if (show) Show.set_value(selector.selector, text);

// first wait for the page to load and the selector to appear
    if (selector is XPath) {
      await (await page).waitForXPath(selector.selector);
    } else {
      await (await page).waitForSelector(selector.selector);
    }
    var selectedElements = await (await page).$$(selector.selector);

    if (selectedElements.length > index) {
      var selected = selectedElements[index];

      if (click) {
        await selected.click();
      }

      await selected.evaluateHandle('''(element, text) => {
      if (element instanceof HTMLInputElement || element instanceof HTMLTextAreaElement || element instanceof HTMLSelectElement) {
        element.focus(); // Focus on the element
        var inputEvent = new Event('input', {bubbles: true});
        var changeEvent = new Event('change', {bubbles: true});
        element.dispatchEvent(inputEvent);
        element.value = text;
        element.dispatchEvent(changeEvent);
        element.blur(); // Remove focus from the element
      }
    }''', args: [text]);
    }

    return this;
  }

  ///sets
  ///sets all the elements that match the selector with a set of values
  /// only tries to set the elements that are available (ignores the rest)
  Future<Online> sets(AbstractSelector selector, List<String> texts,
      {bool show = true}) async {
    if (show) Show.set_values(selector.selector, texts);
    //wait for the selector to appear
    await (await page).waitForSelector(selector.selector);
    //find all the elements that match the selector
    var elements = await (await page).$$(selector.selector);
    for (var i = 0; i < elements.length; i++) {
      if (i < texts.length) {
        var text = texts[i];
        await elements[i].evaluateHandle('''(element, text) => {
        if (element instanceof HTMLInputElement || element instanceof HTMLTextAreaElement || element instanceof HTMLSelectElement) {
          element.focus(); // Focus on the element
          var inputEvent = new Event('input', {bubbles: true});
          var changeEvent = new Event('change', {bubbles: true});
          element.dispatchEvent(inputEvent);
          element.value = text;
          element.dispatchEvent(changeEvent);
          element.blur(); // Remove focus from the element
        }
      }''', args: [text]);
      }
    }
    return this;
  }

  Future<Online> select(AbstractSelector selector, SelectionStrategy strategy,
      {bool show = true}) async {
    if (show) {
      Show.selecting(selector.selector, strategy.getSelectionScript());
    }

    try {
      var selected = selector is XPath
          ? await (await page).waitForXPath(selector.selector)
          : await (await page).waitForSelector(selector.selector);

      if (selected != null) {
        /// Perform the necessary steps to select an option from a select element based on the strategy
        var selectionScript = strategy.getSelectionScript();

        await selected.evaluateHandle('''
        function(element, selectionScript) {
          if (element instanceof HTMLSelectElement && element.options.length > 0) {
            element.focus(); // Focus on the element
            
            // Create and dispatch the input event
            var inputEvent = new Event('input', { bubbles: true });
            element.dispatchEvent(inputEvent);
            
            // Set the selected option based on the selection strategy
            eval(selectionScript);
            
            // Create and dispatch the change event
            var changeEvent = new Event('change', { bubbles: true });
            element.dispatchEvent(changeEvent);
            
            element.blur(); // Remove focus from the element
          } else {
            console.error('Invalid element or no options available');
          }
        }
      ''', args: [selectionScript]);
      } else {
        throw Exception('Element not found for selector: ${selector.selector}');
      }
    } catch (error) {
      // Handle any errors that occur during the selection process
      print('Error during selection: $error');
      // You can choose to rethrow the error or handle it in a specific way
      rethrow;
    }

    return this;
  }

  //unfocus
  Future<Online> unfocus(AbstractSelector selector, {bool show = true}) async {
    if (show) Show.unfocusing(selector.selector);
    var selected = selector is XPath
        ? await (await page).waitForXPath(selector.selector)
        : await (await page).waitForSelector(selector.selector);
    if (selected != null) {
      await selected.evaluate('''(element) => {
      element.blur();
    }''');
    }
    return this;
  }

  /// fill sap grid with data
  /// eg. .grid_fill(WithId//('C120', data)
  /// data is a list of maps
  /// will iterate through the list and fill the grid
  /// set element with id "grid#C120#1,2#if" to "data[0]['1,2']"
  /// set element with id "grid#C120#1,3#if" to "data[0]['1,3']"
  /// set element with id "grid#C120#1,6#if" to "data[0]['1,6']"
  Future<Online> grid_fill(
      SelectorBuilder selectorBuilder, List<Map<String, dynamic>> data) async {
    for (var rowIndex = 0; rowIndex < data.length; rowIndex++) {
      var row = data[rowIndex];
      for (var cellKey in row.keys) {
        // CellKey is expected to be in the format 'row,column'
        var coordinates = cellKey.split(',');
        if (coordinates.length != 2) {
          continue; // Skip invalid keys
        }
        var rowIdx = int.tryParse(coordinates[0]);
        var colIdx = int.tryParse(coordinates[1]);
        if (rowIdx == null || colIdx == null) {
          continue; // Skip if indexes are not integers
        }

        // Build the selector using the provided SelectorBuilder function
        var selector = selectorBuilder(rowIdx, colIdx);
        var cellValue = row[cellKey];

        // Perform the action on the cell, e.g., setting its value
        // This assumes `action` is a function that can take a selector and a value
        await set(selector, cellValue.toString());
      }
    }
    return this;
  }

  Future<Online> set_secret(AbstractSelector selector, String text,
      {Duration? timeout = null, int index = 0}) async {
    Show.setting(selector.selector, text, secret: true);
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
    if (log) Show.setting_range(selector.selector, from, to);
    await Online.set(selector, from, timeout: timeout, index: 0);
    await Online.set(selector, to, timeout: timeout, index: 1);
    return Online;
  }

  /// type
  /// more involved than set. more realistic due to waiting for the element to appear,
  /// scrolling to the element, moving the mouse over the element, focusing on the element by clicking on it
  /// waiting for the focusable child of the element and focusing on it, finding the first input/textarea/select and focusing on it
  /// and then typing the text
  Future<Online> type(AbstractSelector selector, Object? text,
      {bool show = true}) async {
    text ??= '';
    if (show) Show.waiting_for(selector.selector, 'to appear');
    var item = await (await page).waitForSelector(selector.selector);
    if (item != null) {
      if (show) Show.scrolling(selector.selector);
      await item.evaluate('''(element) => {
      element.scrollIntoView({behavior: "auto", block: "center", inline: "center"});
    }''');
      if (show) Show.hover(selector.selector);
      await item.hover();
      if (show) Show.focusing(selector.selector);
      await item.focus();
      // just in case if the element focusable is child of this element, we should bubble up the focus
      await item.evaluate('''(element) => {
      // bubble down the focus to the first focusable child
      var focusable = element.querySelector('input,button,textarea,select');
      if (focusable) {
        focusable.focus();
      }
      else {
        //find the first focusable parent and focus on it
        var parent = element.parentElement;
        while (parent) {
          var focusable = parent.querySelector('input,button,textarea,select');
          if (focusable) {
            focusable.focus();
            break;
          }
          parent = parent.parentElement;
        }
      }
    }''');
      if (show) Show.typing(selector.selector, text.toString());
      await item.type(text.toString());
    }

    return this;
  }

  ///When / Then
  /// eg. wait for a context menu to appear and select the 'Spreadsheet' option from the context menu
  /// when(Css('div[role="menu"]'), (x) => x.click(Css('div[role="menu"]')))
  Future<Online> when(Waitable waitable, MapFunc<Online, dynamic> action,
      {Duration? timeout}) async {
    Show.waiting_for(waitable.toString(), "to be ready");
    await waitable.wait(this);

    await action(this);
    return this;
  }

  //ex
  // executes js and returns online
  // ex('document.querySelector("input").value = "$text";', text: 'hello world');
  Future<Online> ex(MapFunc<ElementHandle, dynamic> script,
      {List<dynamic>? args}) async {
    Show.executing(script.toString());
    await (await page).evaluate(script.toString(), args: args);
    return this;
  }

  //focus
  Future<Online> focus(AbstractSelector selector, {bool show = true}) async {
    if (show) Show.focusing(selector.selector);
    var item = await (await page).waitForSelector(selector.selector);
    if (item != null) {
      await item.evaluate('''(element) => {
      element.scrollIntoView({behavior: "auto", block: "center", inline: "center"});
    }''');
      await item.hover();
      await item.focus();
      // just in case if the element focusable is child of this element, we should bubble up the focus
      await item.evaluate('''(element) => {
      // bubble down the focus to the first focusable child
      var focusable = element.querySelector('input,button,textarea,select');
      if (focusable) {
        focusable.focus();
      }
      else {
        //find the first focusable parent and focus on it
        var parent = element.parentElement;
        while (parent) {
          var focusable = parent.querySelector('input,button,textarea,select');
          if (focusable) {
            focusable.focus();
            break;
          }
          parent = parent.parentElement;
        }
      }
    }''');
    }
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
    Show.waiting_for(selector, "to contain $text");
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
    if (show) Show.clicking(selector.selector);
    var selected = selector is XPath
        ? await (await page).waitForXPath(selector.selector, visible: true)
        : await (await page).waitForSelector(selector.selector, visible: true);
    if (selected != null) {
      //if the element is not visible, scroll to it
      await selected.click(delay: Duration(milliseconds: 100));

      // await scroll_to(selector);
      // await mouse_enter(selector);
      // await mouse_over(selector);
      // await Future.delayed(Duration(milliseconds: 100));
      // await selected.click();
      // await Future.delayed(Duration(milliseconds: 100));
    }
    return this;
  }

  //mouse enter
  Future<Online> mouse_enter(AbstractSelector selector) async {
    Show.mouse_enter(selector.selector);
    var selected = selector is XPath
        ? await (await page).waitForXPath(selector.selector, visible: true)
        : await (await page).waitForSelector(selector.selector, visible: true);
    if (selected != null) {
      await selected.evaluate('''element => {
      var mouseEnterEvent = new MouseEvent('mouseenter', {bubbles: true});
      element.dispatchEvent(mouseEnterEvent);
    }''');
    }
    return this;
  }

  //mouse leave
  Future<Online> mouse_leave(AbstractSelector selector) async {
    Show.mouse_leave(selector.selector);
    var selected = selector is XPath
        ? await (await page).waitForXPath(selector.selector, visible: true)
        : await (await page).waitForSelector(selector.selector, visible: true);
    if (selected != null) {
      await selected.evaluate('''element => {
      var mouseLeaveEvent = new MouseEvent('mouseleave', {bubbles: true});
      element.dispatchEvent(mouseLeaveEvent);
    }''');
    }
    return this;
  }

  //mouse over
  Future<Online> mouse_over(AbstractSelector selector) async {
    Show.action('mouse over', selector.selector);
    var selected = selector is XPath
        ? await (await page).waitForXPath(selector.selector, visible: true)
        : await (await page).waitForSelector(selector.selector, visible: true);
    if (selected != null) {
      await selected.evaluate('''element => {
      var mouseOverEvent = new MouseEvent('mouseover', {bubbles: true});
      element.dispatchEvent(mouseOverEvent);
    }''');
    }
    return this;
  }

  //mouse out
  Future<Online> mouse_out(AbstractSelector selector) async {
    Show.action('mouse out', selector.selector);
    var selected = selector is XPath
        ? await (await page).waitForXPath(selector.selector, visible: true)
        : await (await page).waitForSelector(selector.selector, visible: true);
    if (selected != null) {
      await selected.evaluate('''element => {
      var mouseOutEvent = new MouseEvent('mouseout', {bubbles: true});
      element.dispatchEvent(mouseOutEvent);
    }''');
    }
    return this;
  }

  //scroll to element
  Future<Online> scroll_to(AbstractSelector selector) async {
    Show.action('scrolling', 'to', selector.selector);
    var selected = selector is XPath
        ? await (await page).waitForXPath(selector.selector, visible: true)
        : await (await page).waitForSelector(selector.selector, visible: true);
    if (selected != null) {
      //scroll to the element make sure it is effective and everything loads (wait)
      await selected.evaluate('''element => {
      element.scrollIntoView({behavior: "auto", block: "center", inline: "center"});
    }''');
    }
    //let everything load
    await Future.delayed(Duration(milliseconds: 500));
    return this;
  }

  //scroll by
  Future<Online> scroll_by(int x, int y) async {
    Show.action('scrolling', 'by', x.toString(), y.toString());
    await (await page).evaluate('''() => {
      window.scrollBy($x, $y);
    }''');
    return this;
  }

  //scroll to top
  Future<Online> scroll_to_top() async {
    Show.action('scrolling', 'to', 'top');
    await (await page).evaluate('''() => {
      window.scrollTo(0, 0);
    }''');
    return this;
  }

  //scroll to bottom
  Future<Online> scroll_to_bottom() async {
    Show.action('scrolling', 'to', 'bottom');
    await (await page).evaluate('''() => {
      window.scrollTo(0, document.body.scrollHeight);
    }''');
    return this;
  }

  //scroll to left
  Future<Online> scroll_to_left() async {
    Show.action('scrolling', 'to', 'left');
    await (await page).evaluate('''() => {
      window.scrollTo(0, 0);
    }''');
    return this;
  }

  //scroll to right
  Future<Online> scroll_to_right() async {
    Show.action('scrolling', 'to', 'right');
    await (await page).evaluate('''() => {
      window.scrollTo(document.body.scrollWidth, 0);
    }''');
    return this;
  }

  //maybe_click
  //clicks if it exists and clickable. moves on if it does not.
  //does not cry about things that do not exist or dosent work 😊
  Future<Online> maybe_click(AbstractSelector selector,
      {bool show = true, int index = 0}) async {
    try {
      if (show) Show.action('clicking', selector.selector);
      var selected = selector is XPath
          ? await (await page).waitForXPath(selector.selector,
              visible: true, timeout: minimal_timeout)
          : await (await page).waitForSelector(selector.selector,
              visible: true, timeout: minimal_timeout);
      if (selected != null) {
        await selected.click();
      }
    } catch (e) {
      if (show) Show.error(e.toString());
    }
    return this;
  }

  //set grid cell
  // eg. set_grid_cell("C120", 1, 3, "hello world")
  // will click on element with id=grid#C106#1,3#if
  // type "hello world" element with id=grid#C106#1,3#if

  Future<Online> set_grid_cell(String grid_id, int row, int column, String text,
      {bool show = true}) async {
    var selector = Css('#grid\\#$grid_id\\#$row\\,$column\\#if-r');
    if (show) Show.action('setting', selector.selector, 'to', text);
    await wait(Waitable.Element(selector));
    await wait(Waitable.Milliseconds(500));
    await (await page).click(selector.selector);
    var input_selector = Css('input[id="grid\\#$grid_id\\#$row,$column\\#if"]');
    await (await page).waitForSelector(input_selector.selector);
    await (await page).type(input_selector.selector, text);
    await (await page).keyboard.press(Key.tab);
    return this;
  }

  //set_all
  Future<Online> set_all(AbstractSelector selector, String text) async {
    Show.action('setting', selector.selector, 'to', text);
    await wait(Waitable.ElementVisible(selector));
    await (await page).$$(selector.selector).then((elements) async {
      for (var element in elements) {
        await element.type(text);
      }
    });
    return this;
  }

  //set_attribute
  Future<Online> set_attribute(
      AbstractSelector selector, String attribute, String value) async {
    Show.action('setting', attribute, 'to', value, selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).evaluate('''(selector, attribute, value) => {
      document.querySelector(selector).setAttribute(attribute, value);
    }''', args: [selector.selector, attribute, value]);
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
  Future<Online> right_click(AbstractSelector selector,
      {bool show = true}) async {
    if (show) Show.action('right clicking', selector.selector);
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

  Future<ElementHandle?> get_element(AbstractSelector selector) async {
    return await (await page).waitForSelector(selector.selector);
  }

  Future<Online> wait(Waitable waitable) async {
    await waitable.wait(this);
    return this;
  }

  Future<Online> close() async {
    Show.action('closing', 'browser');
    await browser.close();
    return this;
  }

  Future<Online> clear_value(AbstractSelector selector,
      {bool show = true}) async {
    if (show) Show.action('clearing', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).evaluate('''(selector) => {
      document.querySelector(selector).value = '';
      //trigger change and input events with bubbles
      var inputEvent = new Event('input', {bubbles: true});
      var changeEvent = new Event('change', {bubbles: true});
      document.querySelector(selector).dispatchEvent(inputEvent);
      document.querySelector(selector).dispatchEvent(changeEvent);

    }''', args: [selector.selector]);
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
