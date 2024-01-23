//lets define some waitables
//wait_for(Navigation)
import 'package:nobody/references.dart';

import 'any_selector.dart';

Waitable UntilPageLoaded = (Online online) async {
  Show.action('waiting', 'for', "navigation");
  await (await online.page).waitForNavigation();
  return true;
};

Waitable PageLoad = (Online online) async {
  Show.action('waiting', 'for', "page", "to", "load");
  await (await online.page).waitForNavigation();
  return true;
};

Waitable Seconds(int seconds) => (Online online) async {
      Show.action('waiting', 'for', seconds.toString(), 'seconds');
      await Future.delayed(Duration(seconds: seconds));
      return true;
    };

Waitable Element(String selector) => (Online online) async {
      Show.action('waiting', 'for', selector);
      await (await online.page).waitForSelector(selector);
      return true;
    };

Waitable ElementVisible(AnySelector selector) => (Online online) async {
      Show.action('waiting', 'for', selector.selector, 'to be', 'visible');
      await (await online.page)
          .waitForSelector(selector.selector, visible: true);
      return true;
    };

Waitable ElementHidden(AnySelector selector) => (Online online) async {
      Show.action('waiting', 'for', selector.selector, 'to be', 'hidden');
      await (await online.page)
          .waitForSelector(selector.selector, hidden: true);
      return true;
    };

Waitable Navigation = (Online online) async {
  Show.action('waiting', 'for', "navigation");

  await (await online.page).waitForNavigation(wait: Until.domContentLoaded);
  return true;
};
