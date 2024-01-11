import 'package:nobody/lib.dart';

class Sap {
  static final Execute = Sap.Button("Execute (F8)");
  static final Back = Sap.Button("Back (F3)");
  static final Cancel = Sap.Button("Cancel (F12)");
  static final Save = Sap.Button("Save (Ctrl+S)");
  static final Enter = Sap.Button("Enter (Enter)");
  static final Exit = Sap.Button("Exit (Shift+F3)");
  static final CreateNew = Sap.Button("Create New Items (F7)");

  static AbstractSelector Button(String label) =>
      Css('div[role="button"][title="$label"]');
  static AbstractSelector Input(String label) =>
      Css('input[title="$label"][name="InputField"][class="lsField__input"]');

  /*
  title="Purchasing Document Number"
  class="lsField__input"
  aria-haspopup="listbox"
  name="InputField"
  lsevents="{&quot;Change&quot;:[{},{&quot;code&quot;:&quot;value&quot;,&quot;direct&quot;:true,&quot;setsid&quot;:true}],&quot;Select&quot;:[{},{&quot;code&quot;:&quot;value&quot;,&quot;direct&quot;:true,&quot;setsid&quot;:true}],&quot;Validate&quot;:[{},{}],&quot;DeleteItem&quot;:[{},{&quot;setsid&quot;:true}],&quot;ListAccess&quot;:[{&quot;ResponseData&quot;:&quot;delta&quot;,&quot;TransportMethod&quot;:&quot;full&quot;,&quot;EnqueueCardinality&quot;:&quot;none&quot;},{&quot;maxlen&quot;:0,&quot;setsid&quot;:true,&quot;content&quot;:&quot;typeahead&quot;,&quot;parentid&quot;:&quot;USRAREA&quot;}],&quot;DoubleClick&quot;:[{},{&quot;code&quot;:&quot;action/2&quot;,&quot;setsid&quot;:true,&quot;submit&quot;:true}],&quot;FieldHelpPress&quot;:[{},{&quot;code&quot;:&quot;vkey/4&quot;,&quot;submit&quot;:true,&quot;wndsid&quot;:true}],&quot;ActionItemActivate&quot;:[{},{&quot;code&quot;:&quot;vkey/0/ses[0]&quot;,&quot;submit&quot;:true}],&quot;ClipboardTablePaste&quot;:[{},{&quot;code&quot;:&quot;action/25&quot;,&quot;type&quot;:&quot;GuiTextField&quot;,&quot;setsid&quot;:true,&quot;submit&quot;:true}]}"
  lsdata="{&quot;sBehavior&quot;:&quot;FREETEXT&quot;,&quot;sItemListBoxId&quot;:&quot;M0:46:::0:34_TALB&quot;,&quot;bContainerWidthSet&quot;:true,&quot;bShowHelpButtonAlways&quot;:true,&quot;sSuggestFilter&quot;:&quot;SERVER&quot;,&quot;bHideFieldHelp&quot;:true,&quot;bFieldHelpFloating&quot;:false,&quot;sCustomData&quot;:{&quot;SID&quot;:&quot;wnd[0]/usr/ctxtEN_EBELN-LOW&quot;,&quot;Type&quot;:&quot;GuiCTextField&quot;,&quot;ctmenu&quot;:1,&quot;maxlen&quot;:10,&quot;focusable&quot;:&quot;X&quot;},&quot;sCustomStyle&quot;:&quot;pstxt&quot;,&quot;sLabelledBy&quot;:&quot;M0:46:::0:0&quot;}"

   */

  static Authable User(String username) => SapUser(username);
  static AbstractUrl get Fiori => SapFiori();
  static AbstractUrl Transaction(String code) => Transaction(code);

  static AbstractDownloadable get DownloadableTable => DownloadableSapTable();

  static AbstractSelector InputFields = Css('[class="lsField__input"]');

  /// Table id is not unique, so we need to use the index to get the right table
  /// usually the first table is the one we want to use
  static AbstractSelector get Table => Css('table[role="grid"]');

  /// Header of first table
  /// usually the first table is the one we want to use
  static AbstractSelector get TableHeader => Css('table[role="grid"]>tbody>tr');
}

class SapUser implements Authable {
  final String username;
  AbstractPassword get password => Password.From(scope: 'sap', key: username);
  AbstractUrl get url => Url('https://cbs.almansoori.biz');

  const SapUser(this.username);

  @override
  Future<Online> login(Online browser) async {
    try {
      var pss = await password.password;
      await browser
          .visit(url.url)
          .set(Input.WithId('logonuidfield'), username)
          .set(Input.WithId('logonpassfield'), pss)
          .click(Input.WithName('uidPasswordLogon'))
          .wait(UntilPageLoaded)
          .wait(ElementVisible(Css(
              'span[class="sapUshellAppTitle sapUshellAppTitleClickable"]')));
    } catch (e) {
      print(e);
    }
    return browser;
  }
}

class SapFiori implements AbstractUrl {
  String get url =>
      'https://cbs.almansoori.biz/sap/bc/ui5_ui5/ui2/ushell/shells/abap/FioriLaunchpad.html?sap-client=800&sap-language=EN';
  const SapFiori();
}

class SapTransaction implements AbstractUrl {
  final String code;
  String get url =>
      'https://cbs.almansoori.biz/sap/bc/gui/sap/its/webgui/?sap-client=800&~TRANSACTION=$code#';
  const SapTransaction(this.code);
}
