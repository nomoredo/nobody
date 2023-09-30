import 'package:nobody/references.dart';

void main(List<String> arguments) async {
  Show.banner(banner, footer);
  Show.credits(
      'DEVELOPED BY', 'AGHIL MOHANDAS', 'FOR', 'ALMANSOORI WIRELINE SERVICES');
  // await run_GoogleSearch();
  // await po_export();
  // await create_pr();
  // await check_email();
  // read_excel();
  // await generate_trf_report();
  // await generate_mb51_report();
  await create_trip_request();
}

//create trip request

//generate MB51 report
Future generate_mb51_report() async {
  return Nobody.online()
      .login(Sap('amohandas'))
      .goto(Transaction("MB51"))
      .click(SapButton("Execute (F8)"))
      .download(DownloadableSapTable(), SimplePath("example.xlsx"))
      .wait(Seconds(20));
}

//generate TRF report
Future generate_trf_report() async {
  return Nobody.online()
      .login(Sap('amohandas'))
      .goto(Transaction("ZTR01"))
      .map(SapInputFields, Print)
      .set(SapInput('Company Code'), '2200')
      .click(SapButton("Execute (F8)"))
      .download(DownloadableSapTable(), SimplePath("example.xlsx"))
      .wait(Seconds(20));
}

Future run_GoogleSearch() {
  return Nobody.online(slow: Duration(seconds: 1))
      .visit('https://search.brave.com/')
      .type('input[id="searchbox"]', 'pretty girl')
      .click(Button.WithId('submit-button'))
      .wait(UntilPageLoaded)
      .click(XPath('/html/body/div/div[1]/div/nav/ul[1]/li[2]/a/span[2]'))
      .wait(UntilPageLoaded)
      .wait(Seconds(5))
      .close();
}

Future po_export() async {
  return Nobody.online()
      .login(Sap('amohandas'))
      .goto(Transaction("ME2N"))
      .map(SapInputFields, Print)
      .set(SapInput('Purchasing organization'), '2200')
      .set_range(
          SapInput('Purchasing Document Date'), '01.01.2023', '30.06.2023')
      .set(SapInput("Plant"), "22A2")
      .set(SapInput("Purchasing Group"), "161")
      .click(SapButton("Execute (F8)"))
      .download(DownloadableSapTable(), SimplePath("example.xlsx"))
      .wait(Seconds(20));
}

Future create_pr() {
  return Nobody.online()
      .login(Sap('amohandas'))
      .goto(Transaction("ME51N"))
      .map(SapInputFields, Print)
      .wait(Seconds(20))
      .close();
}

Future check_email() async {
  return await Nobody.at_office('amohandas')
      .read_mails()
      .with_subject('test')
      .from('amohandas')
      .get();
}

Future read_excel() async {
  final purchase_orders =
      await Nobody.open(ExcelFile(r"C:\Users\aghil\Downloads\EXPORT (10).xlsx"))
          .sheet("Sheet1")
          .rows((r) => r.cells.first != null)
          .take(50)
          .map((x) =>
              {"po": x.string(0), "item": x.string(1), "qty": x.integer(2)});
  for (final po in purchase_orders) {
    print(po);
  }
}

final Print = (x) {
  Show.anything(x);
  return x;
};

// input fields have lsField__input in their class list
final SapInputFields = Css('input.lsField__input');

// banner and footer has "works for you" in yellow
const banner = r"""
                        __              __      
           ____  ____  / /_  ____  ____/ /_  __
          / __ \/ __ \/ __ \/ __ \/ __  / / / /
         / / / / /_/ / /_/ / /_/ / /_/ / /_/ / 
        /_/ /_/\____/_.___/\____/\__,_/\__, / """;

const footer =
    '        \u001b[33mWORKS FOR Y🌘U                \u001b[0m/____/  ';

//create trip request.
Future create_trip_request() async {
  return Nobody.online()
      .login(Sap('amohandas'))
      .goto(Fuori("ZTRV_FORM_REQ"))
      .click(XPath('//*[@id="__xmlview0--RB3-4"]/div'))
      .click(XPath('//*[@id="__xmlview0--idEmpNo-inner"]'))
      .set(XPath('//*[@id="__xmlview0--idEmpNo-inner"]'), '9711068')
      .key_down(Key.enter)
      .key_up(Key.enter)
      .click(XPath('//*[@id="__item51-__clone0_cell0"]'))
      .wait(ElementHidden(XPath('//*[@id="empfragment-searchField-I"]')))
      .click(XPath('//*[@id="__xmlview0--GO-BDI-content"]'))
      .click(XPath('//*[@id="__xmlview0--RB32"]/div/svg/circle[2]'))
      .click(XPath('//*[@id="__xmlview0--idFocal-vhi"]'))
      .click(XPath('//*[@id="__item51-__clone41"]'))
      .click(XPath('//*[@id="__xmlview0--idRefNo-inner"]'))
      .set(XPath('//*[@id="__xmlview0--idRefNo-inner"]'), 'mws/ar/ooo5')
      .click(XPath('//*[@id="__xmlview0--idContact-inner"]'))
      .wait(Seconds(1));
}
