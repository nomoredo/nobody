import 'package:nobody/mail_query.future.dart';
import 'package:nobody/references.dart';

void main(List<String> arguments) async {
  // await run_GoogleSearch();
  // await run_ME2N();
  // await create_pr();
  await check_email();
}

Future run_GoogleSearch() {
  return Nobody.online(slow: Duration(seconds: 1))
      .visit('https://search.brave.com/')
      .type('input[id="searchbox"]', 'pretty girl')
      .click(Button.WithId('submit-button'))
      .wait(UntilPageLoaded)
      // click on the <a> element with a child <span> element with text "Images"
      .click(XPath('/html/body/div/div[1]/div/nav/ul[1]/li[2]/a/span[2]'))
      .wait(UntilPageLoaded)
      .wait(Seconds(5))
      .close();
}

Future run_ME2N() async {
  return Nobody.online()
      // .capture_download()
      .login(Sap('amohandas'))
      .goto(Transaction("ME2N"))
      .list(SapInput.All())
      .set(SapInput('Purchasing organization'), '2200')
      .set(SapInput('Purchasing Document Type'), 'ZC*')
      .set_range(
          SapInput('Purchasing Document Date'), '01.01.2023', '30.06.2023')
      .set(SapInput("Plant"), "22A2")
      .set(SapInput("Purchasing Group"), "161")
      .click(SapButton("Execute (F8)"))
      .download(DownloadableSapTable(), SimplePath("example.xlsx"))
      .wait(Seconds(20));

  // sap.transaction('ME2N').waitFor(Seconds(10));
}

Future create_pr() {
  return Nobody.online()
      .login(Sap('amohandas'))
      .goto(Transaction("ME51N"))
      .list(SapInput.All())
      .wait(Seconds(20))
      .close();
}

Future check_email() async {
  return await Nobody.at_office('amohandas')
      // .graph('/me/messages')
      .read_mails()
      .with_subject('test')
      .from('amohandas')
      .get();
}
