import 'package:nobody/references.dart';

void main(List<String> arguments) async {
  // await run_GoogleSearch();
  // await po_export();
  // await create_pr();
  // await check_email();
  // read_excel();
  // await generate_trf_report();
  // await generate_mb51_report();
  // await create_trip_request();
}

//create trip request

//generate MB51 report

//generate TRF report

Future run_GoogleSearch() {
  return Nobody()
      .online(slow: Duration(seconds: 1))
      .visit('https://search.brave.com/')
      .type('input[id="searchbox"]', 'pretty girl')
      .click(Button.WithId('submit-button'))
      .wait(UntilPageLoaded)
      .click(XPath('/html/body/div/div[1]/div/nav/ul[1]/li[2]/a/span[2]'))
      .wait(UntilPageLoaded)
      .wait(Seconds(5))
      .close();
}

Future create_pr() {
  return Nobody()
      .online()
      .login(Sap.User('amohandas'))
      .goto(SapTransaction("ME51N"))
      // .map(Sap.InputFields, Print)
      .wait(Seconds(20))
      .close();
}

Future read_excel() async {
  final purchase_orders = await Nobody()
      .open(ExcelFile(r"C:\Users\aghil\Downloads\EXPORT (10).xlsx"))
      .sheet("Sheet1")
      .rows((r) => r.cells.first != null)
      .take(50)
      .map(
          (x) => {"po": x.string(0), "item": x.string(1), "qty": x.integer(2)});
  for (final po in purchase_orders) {
    print(po);
  }
}

final Print = (x) {
  Show.anything(x);
  return x;
};

//create trip request.
Future create_trip_request() async {
  return Nobody()
      .online()
      .login(Sap.User('amohandas'))
      .goto(SapFiori())
      .wait(Seconds(3))
      .click(Css('a[id="__tile38"]'))
      .click(Css('#__xmlview0--RB3-4 > div > svg > circle.sapMRbBInn'))
      .set(Css('#__xmlview0--idEmpNo-inner'), '9711068')
      //click go
      .click(Css('#__xmlview0--GO-BDI-content'))
      //click new booking
      .click(Css('#__xmlview0--RB21'))
      //click focal
      .click(Css('#__xmlview0--idFocal-vhi'))
      .ex((x) => x.click())
      .when_contains('div.sapMSLITitle', '9711068', (x) => x.click())
      .wait(Seconds(10))
      .click(XPath('//*[@id="__xmlview0--idFocal-vhi"]'))
      .click(XPath('//*[@id="__item51-__clone41"]'))
      .click(XPath('//*[@id="__xmlview0--idRefNo-inner"]'))
      .set(XPath('//*[@id="__xmlview0--idRefNo-inner"]'), 'mws/ar/ooo5')
      .click(XPath('//*[@id="__xmlview0--idContact-inner"]'))
      .wait(Seconds(1));
}
