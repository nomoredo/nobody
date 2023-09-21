import 'package:nobody/nobody.dart';
import 'package:nobody/nobody.future.dart';

void main(List<String> arguments) async {
  // await run_GoogleSearch();
  await run_ME2N();
}

Future run_GoogleSearch() {
  return Nobody.online(slow: false)
      .visit('https://search.brave.com/')
      .type('input[id="searchbox"]', 'pretty girl')
      .click('button[id="submit-button"]')
      .waitFor(Navigation)
      // click on the <a> element with a child <span> element with text "Images"
      .click('/html/body/div/div[1]/div/nav/ul[1]/li[2]/a/span[2]')
      .waitFor(Navigation)
      .waitFor(Seconds(5))
      .close();
}

Future run_ME2N() async {
  var sap = await Nobody.sap(username: "amohandas");

  // sap.transaction('ME2N').waitFor(Seconds(10));
}
