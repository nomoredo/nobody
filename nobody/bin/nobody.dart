import 'package:nobody/references.dart';

void main(List<String> arguments) async {
  // await run_GoogleSearch();
  // await po_export();
  // await create_pr();
  // await check_email();
  // read_excel();
  await generate_trf_report();
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
