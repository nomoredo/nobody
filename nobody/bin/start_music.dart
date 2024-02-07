import 'package:nobody/references.dart';

void main(List<String> arguments) async {
  await export_emp_attendance();
}

Future export_emp_attendance() async {
  await Nobody()
      .online()
      .goto(Url("https://youtube.com"))
      .type("input#search", "kachi sera")
      .click(Button.WithId("search-icon-legacy"))
      .wait(Waitable.Navigation())
      .click(Css("a#video-title"))
      .wait(Waitable.PageLoaded())
      .wait(Waitable.Seconds(10));
}















// //create reservation
// Future create_reservation() async {
//   return Nobody()
//       .online()
//       .login(Sap.User('amohandas'))
//       .goto(SapTransaction("MB21"))
//       .set(Sap.Input("Movement type (inventory management)"), "221")
//       .set(Sap.Input("Plant"), "22A1")
//       .click(Sap.CreateNew)
//       .set(Sap.Input("Work Breakdown Structure Element (WBS Element)"),
//           "MWS-AE-0017.01.001")
//       .set(
//           XPath(
//               "/html/body/table/tbody/tr/td/div/form/div/div[4]/div/div[9]/table/tbody/tr[2]/td/table/tbody/tr/td/div/div/div/div[9]/div/div[2]/table/tbody/tr/td/input"),
//           "1000004543")
//       .wait(Seconds(10));
// }

// Future run_GoogleSearch() {
//   return Nobody()
//       .online(slow: Duration(seconds: 1))
//       .visit('https://search.brave.com/')
//       .type('input[id="searchbox"]', 'pretty girl')
//       .click(Button.WithId('submit-button'))
//       .wait(UntilPageLoaded)
//       .click(XPath('/html/body/div/div[1]/div/nav/ul[1]/li[2]/a/span[2]'))
//       .wait(UntilPageLoaded)
//       .wait(Seconds(5))
//       .close();
// }

// Future create_pr() {
//   return Nobody()
//       .online()
//       .login(Sap.User('amohandas'))
//       .goto(SapTransaction("ME51N"))
//       // .map(Sap.InputFields, Print)
//       .wait(Seconds(20))
//       .close();
// }

// Future read_excel() async {
//   final purchase_orders = await Nobody()
//       .open(ExcelFile(r"C:\Users\aghil\Downloads\EXPORT (10).xlsx"))
//       .sheet("Sheet1")
//       .rows((r) => r.cells.first != null)
//       .take(50)
//       .map(
//           (x) => {"po": x.string(0), "item": x.string(1), "qty": x.integer(2)});
//   for (final po in purchase_orders) {
//     print(po);
//   }
// }

// final Print = (x) {
//   // Show.anything(x);
//   return x;
// };

// //create trip request.
// Future create_trip_request() async {
//   return Nobody()
//       .online()
//       .login(Sap.User('amohandas'))
//       .goto(SapFiori())
//       .wait(Seconds(3))
//       .click(Css('a[id="__tile38"]'))
//       .click(Css('#__xmlview0--RB3-4 > div > svg > circle.sapMRbBInn'))
//       .set(Css('#__xmlview0--idEmpNo-inner'), '9711068')
//       //click go
//       .click(Css('#__xmlview0--GO-BDI-content'))
//       //click new booking
//       .click(Css('#__xmlview0--RB21'))
//       //click focal
//       .click(Css('#__xmlview0--idFocal-vhi'))
//       .ex((x) => x.click())
//       .when_contains('div.sapMSLITitle', '9711068', (x) => x.click())
//       .wait(Seconds(10))
//       .click(XPath('//*[@id="__xmlview0--idFocal-vhi"]'))
//       .click(XPath('//*[@id="__item51-__clone41"]'))
//       .click(XPath('//*[@id="__xmlview0--idRefNo-inner"]'))
//       .set(XPath('//*[@id="__xmlview0--idRefNo-inner"]'), 'mws/ar/ooo5')
//       .click(XPath('//*[@id="__xmlview0--idContact-inner"]'))
//       .wait(Seconds(1));
// }
