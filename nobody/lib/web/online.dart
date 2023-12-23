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

  Future<Online> log_responses() async {
    await (await page).onResponse.listen((response) async {
      print("RESPONSE: ${response.status} ${response.url}");
      if (response.request.postData != null) {
        print("POST DATA: ${response.request.postData}");
      }
    });
    return this;
  }

  Future<Online> login(Authable authable) async {
    Show.action('authenticating', authable.username);
    return await authable.login(this);
  }

  Future<Online> visit(String url) async {
    Show.action('visiting', url.clean_url());
    await (await page).goto(url, wait: Until.domContentLoaded);
    return this;
  }

  Future<Online> goto(AbstractUrl url) async {
    var clean_url = Uri.encodeFull(url.url);
    Show.action('visiting', clean_url.clean_url());
    await (await page).goto(clean_url, wait: Until.domContentLoaded);
    return this;
  }

  //navigate
  Future<Online> navigate(String url) async {
    // clean up url to make sure it is valid
    if (!url.startsWith('http')) {
      url = 'https://$url';
    }
    //handle # ? and other special characters
    url = Uri.encodeFull(url);

    Show.action('navigating to', url);
    await (await page).goto(url, wait: Until.load);
    return this;
  }

  Future<Online> set(AbstractSelector selector, String text,
      {Duration? timeout = null, int index = 0}) async {
    Show.action('set', 'value', text);
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
  Future<Online> focus(AbstractSelector selector) async {
    Show.action('focus', selector.selector);
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
  Future<Online> click(AbstractSelector selector) async {
    Show.action('clicking', selector.selector);
    if (selector is XPath) {
      var selected = await (await page).waitForXPath(selector.selector);
      if (selected != null) {
        await selected.click();
      }
    } else {
      var selected = await (await page).waitForSelector(selector.selector);
      if (selected != null) {
        await selected.click();
      }
    }
    return this;
  }

  //press
  Future<Online> press(Key key) async {
    Show.action('pressing', key.toString());

    await (await page).keyboard.press(key);
    return this;
  }

  //submit form
  Future<Online> submit(AbstractSelector selector) async {
    Show.action('submitting', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).evaluate('''(selector) => {
      document.querySelector(selector).submit();
    }''', args: [selector.selector]);
    return this;
  }

  //right click
  Future<Online> right_click(AbstractSelector selector) async {
    Show.action('right click', selector.selector);
    await (await page).waitForSelector(selector.selector);
    await (await page).click(selector.selector, button: MouseButton.right);
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
  Future<Online> key_down(Key key) async {
    Show.action('key down', key.toString());
    await (await page).keyboard.down(key);
    return this;
  }

  //key up
  Future<Online> key_up(Key key) async {
    Show.action('key up', key.toString());
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
    await (await page).waitForSelector(selector.selector);
    var elements = await (await page).evaluate('''(selector) => {
      return Array.from(document.querySelectorAll(selector)).map((e) => e.outerHTML);
    }''', args: [selector.selector]);
    Show.table(elements);
    return this;
  }

  /// List inputs
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
    Show.table(elements);
    return this;
  }

  /// List forms

  //lists all elements matching the selector
  // all input fields have class containing 'lsField__input'
  // all buttons have class containing 'lsButton'
  // all dropdowns have class containing 'lsField__input' and aria-roledescription="Select"
  Future<Online> list_all(AbstractSelector selector) async {
    Show.action('listing', selector.selector);
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

  List<Map<String, String>> recordedActions = [];

  // Start recording user actions
  Future<Online> start_record() async {
    Show.action('INJECTING RECORD BUTTON AND LIST',
        'Injecting record button and action list...');

    // Inject JavaScript code to create the record button and action list
    await (await page).evaluate('''() => {
      // Create a container for the record button and action list
      const container = document.createElement('div');
      container.style.display = 'flex';
      container.style.height = '100%';

      // Create a div for the current view (shrink to the left)
      const currentView = document.createElement('div');
      currentView.style.flex = '1';
      currentView.style.overflow = 'auto';
      container.appendChild(currentView);

      // Create a div for the record button and action list (on the right)
      const rightPanel = document.createElement('div');
      rightPanel.style.width = '300px'; // Adjust the width as needed
      rightPanel.style.overflow = 'auto';
      container.appendChild(rightPanel);

      // Create the record button
      const recordButton = document.createElement('button');
      recordButton.innerText = 'Record';
      recordButton.id = 'recordButton';
      rightPanel.appendChild(recordButton);

      // Create an ordered list for displaying recorded actions
      const actionList = document.createElement('ol');
      actionList.id = 'actionList';
      rightPanel.appendChild(actionList);

      // Initialize a variable to track recording state
      let isRecording = false;

      // Function to start recording
      async function start_record() {
        isRecording = true;
        recordButton.innerText = 'Stop Recording';
        console.log('Recording started...');

        // Your existing code for recording actions here...
      }

      // Function to stop recording
      async function stop_record() {
        if (isRecording) {
          isRecording = false;
          recordButton.innerText = 'Record';
          console.log('Recording stopped...');

          // Your existing code for stopping and exporting actions here...
        }
      }

      // Function to add an action to the action list
      function addActionToUI(action, details) {
        const listItem = document.createElement('li');
        listItem.innerText = `\${action}: \${details}`;
        actionList.appendChild(listItem);
      }

      // Add click event listener to the record button
      recordButton.addEventListener('click', () => {
        if (isRecording) {
          stop_record();
        } else {
          start_record();
        }
      });

      // Function to record actions and add them to the action list
      function recordAction(action, details) {
        if (isRecording) {
          addActionToUI(action, details);
        }
      }

      // Replace your existing event listeners with recordAction calls
      document.addEventListener('click', (event) => {
        const selector = getOptimalSelector(event.target);
        recordAction('CLICK', selector);
        // Your existing code for click actions...
      });

      document.addEventListener('input', (event) => {
        const selector = getOptimalSelector(event.target);
        recordAction('INPUT', selector);
        // Your existing code for input actions...
      });

      // Add more event listeners for other actions (e.g., hover, keypress) as needed
    }''');

    return this;
  }

  // Stop recording and export actions
  Future<Online> stop_record(String outputFilePath) async {
    // Export the recorded actions to a script file
    var exportedActions = await (await page).evaluate('''() => {
      return JSON.stringify(window.recordedActions);
    }''');

    final scriptContent = exportedActions.toString();
    await File(outputFilePath).writeAsString(scriptContent);

    Show.action('RECORDING ACTIONS',
        'Recording completed. Script exported to $outputFilePath');
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
