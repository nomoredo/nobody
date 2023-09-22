import 'package:nobody/references.dart';

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
  return Nobody.online(slow: false)
      .login(Sap('amohandas'))
      .goto(Transaction("ME2N"))
      .set(SapInput("Selection variant"), "ZTEST")
      .set(SapInput("Purchasing group"), "100")
      .set(SapInput("Purchasing Document"), "4500000000")
      .click(SapButton("Execute"))
      .waitFor(SapTable("Purchase order"))
      // .export(
      //     SapTable("Purchase order"), "C:\\Users\\amohandas\\Desktop\\test.csv")
      .close();

  // sap.transaction('ME2N').waitFor(Seconds(10));
}
