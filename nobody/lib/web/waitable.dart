//lets define some waitables
//wait_for(Navigation)
import 'package:nobody/references.dart';

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

Waitable ElementVisible(AbstractSelector selector) => (Online online) async {
      Show.action('WAITING', 'FOR', selector.selector, 'TO BE VISIBLE');
      await (await online.page)
          .waitForSelector(selector.selector, visible: true);
      return true;
    };

Waitable ElementHidden(AbstractSelector selector) => (Online online) async {
      Show.action('WAITING', 'FOR', selector.selector, 'TO BE HIDDEN');
      await (await online.page)
          .waitForSelector(selector.selector, hidden: true);
      return true;
    };

Waitable Navigation = (Online online) async {
  Show.action('WAITING', 'FOR', "NAVIGATION");

  await (await online.page).waitForNavigation(wait: Until.domContentLoaded);
  return true;
};
