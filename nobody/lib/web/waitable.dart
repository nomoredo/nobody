//lets define some waitables
//wait_for(Navigation)
import 'package:nobody/references.dart';

// typedef Waitable<T> = Future<bool> Function(Online);

abstract class Waitable {
  Future<bool> wait(Online online);

  const Waitable();

  factory Waitable.Duration(Duration duration) => WaitableDuration(duration);
  factory Waitable.Seconds(int seconds) =>
      WaitableDuration(Duration(seconds: seconds));
  factory Waitable.Milliseconds(int milliseconds) =>
      WaitableDuration(Duration(milliseconds: milliseconds));
  factory Waitable.Minutes(int minutes) =>
      WaitableDuration(Duration(minutes: minutes));
  factory Waitable.Hours(int hours) => WaitableDuration(Duration(hours: hours));
  factory Waitable.Days(int days) => WaitableDuration(Duration(days: days));

  /// Wait for an event to occur
  factory Waitable.Event(Future Function(Online) action) =>
      WaitableEvent(action);

  /// Wait for navigation to occur
  factory Waitable.Navigation({Until? until, Duration? timeout}) =>
      WaitableEvent.Navigation(until: until, timeout: timeout);

  /// Wait for page to load
  factory Waitable.PageLoaded({Duration? timeout}) =>
      WaitableEvent.Navigation(until: Until.domContentLoaded, timeout: timeout);

  /// Wait for an element to appear
  factory Waitable.Element(AbstractSelector selector,
          {bool visible = true, bool hidden = false, Duration? timeout}) =>
      WaitableEvent.Element(selector,
          visible: visible, hidden: hidden, timeout: timeout);

  /// Wait for an element to be visible
  factory Waitable.ElementVisible(AbstractSelector selector,
          {Duration? timeout}) =>
      WaitableEvent.Element(selector, visible: true, timeout: timeout);

  /// Wait for an element to be hidden
  factory Waitable.ElementHidden(AbstractSelector selector,
          {Duration? timeout}) =>
      WaitableEvent.Element(selector, hidden: true, timeout: timeout);
}

class WaitableDuration implements Waitable {
  final Duration duration;
  const WaitableDuration(this.duration);

  @override
  Future<bool> wait(Online online) async {
    Show.action('waiting', 'for', duration.inSeconds.toString(), 'seconds');
    await Future.delayed(duration);
    return true;
  }
}

class WaitableEvent implements Waitable {
  final Future Function(Online) action;
  const WaitableEvent(this.action);

  @override
  Future<bool> wait(Online online) async {
    return await action(online);
  }

  factory WaitableEvent.Navigation({Until? until, Duration? timeout}) =>
      WaitableEvent((online) async {
        Show.action('waiting', 'for', "navigation");
        await (await online.page)
            .waitForNavigation(wait: until, timeout: timeout);
        return true;
      });

  factory WaitableEvent.Element(AbstractSelector selector,
          {bool visible = true, bool hidden = false, Duration? timeout}) =>
      WaitableEvent((online) async {
        Show.action('waiting', 'for', selector.selector);
        await (await online.page).waitForSelector(selector.selector,
            visible: visible, hidden: hidden, timeout: timeout);
        return true;
      });
}






// Waitable UntilPageLoaded = (Online online) async {
//   Show.action('waiting', 'for', "navigation");
//   await (await online.page).waitForNavigation();
//   return true;
// };

// Waitable PageLoad = (Online online) async {
//   Show.action('waiting', 'for', "page", "to", "load");
//   await (await online.page).waitForNavigation();
//   return true;
// };

// Waitable Seconds(int seconds) => (Online online) async {
//       Show.action('waiting', 'for', seconds.toString(), 'seconds');
//       await Future.delayed(Duration(seconds: seconds));
//       return true;
//     };

// Waitable Element(String selector) => (Online online) async {
//       Show.action('waiting', 'for', selector);
//       await (await online.page).waitForSelector(selector);
//       return true;
//     };

// Waitable ElementVisible(AbstractSelector selector) => (Online online) async {
//       Show.action('waiting', 'for', selector.selector, 'to be', 'visible');
//       await (await online.page)
//           .waitForSelector(selector.selector, visible: true);
//       return true;
//     };

// Waitable ElementHidden(AbstractSelector selector) => (Online online) async {
//       Show.action('waiting', 'for', selector.selector, 'to be', 'hidden');
//       await (await online.page)
//           .waitForSelector(selector.selector, hidden: true);
//       return true;
//     };

// Waitable Navigation = (Online online) async {
//   Show.action('waiting', 'for', "navigation");

//   await (await online.page).waitForNavigation(wait: Until.domContentLoaded);
//   return true;
// };
