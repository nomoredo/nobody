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
