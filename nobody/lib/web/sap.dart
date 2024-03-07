import 'package:nobody/lib.dart';

class Sap {
  static final Execute = Sap.Button("Execute (F8)");
  static final Back = Sap.Button("Back (F3)");
  static final Cancel = Sap.Button("Cancel (F12)");
  static final Save = Sap.Button("Save (Ctrl+S)");
  static final Enter = Sap.Button("Enter (Enter)");
  static final Exit = Sap.Button("Exit (Shift+F3)");
  static final CreateNew = Sap.Button("Create New Items (F7)");
  static AbstractSelector Data(String data) => SapDataField(data);

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

  /// Grid cell
  static AbstractSelector GridCell(String grid_id, int row, int column) => Css(
      'table[role="grid"][id="$grid_id"] td[lsmatrixcolindex="$column"][lsmatrixrowindex="$row"]');

  static AbstractSelector InputWithData(String s) => SapInputWithData(s);

  static AbstractSelector InputForData(String lsdata) =>
      SapInputWithinData(lsdata);
}

/// for sap specific data fields
/// for example
/// if the field html is as follows
/*
<td id="tbl2834[1,3]" subct="STC" lsdata="{&quot;2&quot;:&quot;EDIT&quot;,&quot;7&quot;:{&quot;SID&quot;:&quot;wnd[0]/usr/subSUB0:SAPLMEGUI:0019/subSUB3:SAPLMEVIEWS:1100/subSUB2:SAPLMEVIEWS:1200/subSUB1:SAPLMEGUI:1301/subSUB2:SAPLMEGUI:3303/tabsREQ_ITEM_DETAIL/tabpTABREQDT1/ssubTABSTRIPCONTROL1SUB:SAPLMEGUI:1328/subSUB0:SAPLMLSP:0400/tblSAPLMLSPTC_VIEW/ctxtESLL-SRVPOS[2,0]&quot;,&quot;Type&quot;:&quot;SAPTABLECSCELL&quot;}}" udat="hotspot" ctv="C" role="gridcell" lsmatrixrowindex="1" lsmatrixcolindex="3" acf="CSEL" ut="3" align="left" class="urSTC urST5HasContentDiv urST5L urST3TDIn urCursorClickable urStd urST3Cl" style=";white-space:nowrap;height:24px">...</td>
*/
/// we can access the field using the following selector
/// SapDataField('wnd[0]/usr/subSUB0:SAPLMEGUI:0019/subSUB3:SAPLMEVIEWS:1100/subSUB2:SAPLMEVIEWS:1200/subSUB1:SAPLMEGUI:1301/subSUB2:SAPLMEGUI:3303/tabsREQ_ITEM_DETAIL/tabpTABREQDT1/ssubTABSTRIPCONTROL1SUB:SAPLMEGUI:1328/subSUB0:SAPLMLSP:0400/tblSAPLMLSPTC_VIEW/ctxtESLL-SRVPOS[2,0]')
/// it will automatically replace unsafe characters with escaped representation and build the selector from it that can be used to access the field in the browser
class SapDataField implements AbstractSelector {
  final String data;

  String get selector => '[lsdata*="${safe_data}"]';

  // Escapes special characters for CSS selectors
  String get safe_data {
    var escapedData = data;
    // Matches characters that need escaping: [ ] , : " ' = > ~ + * $ ^ | ! ? { } ; / ( ) ` and space
    var specialCharsRegExp = RegExp(r'([\[\],:\"\;=><~+\*\$^\|!\?{}\(\)/` ])');
    escapedData = escapedData.replaceAllMapped(
        specialCharsRegExp, (match) => '\\${match.group(0)}');
    return escapedData;
  }

  const SapDataField(this.data);
}

class SapInputWithData extends SapDataField {
  String get selector => 'input[lsdata*="${safe_data}"]';
  const SapInputWithData(String data) : super(data);
}

/// when the input field is nested within an element with lsdata attribute
/// this will match the first input field within the element with matching lsdata
/// even if the input field itself does not have lsdata attribute
class SapInputWithinData extends SapDataField {
  String get selector => '[lsdata*="${safe_data}"] input';
  const SapInputWithinData(String data) : super(data);
}

class SapUser implements Authable {
  final String username;
  AbstractPassword get password => Password.From(scope: 'sap', key: username);
  AbstractUrl get url => Url(
      'https://cbs.almansoori.biz/sap/bc/gui/sap/its/webgui/?sap-client=800")');

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
          .wait(Waitable.PageLoaded())
          .wait(Waitable.ElementVisible(Css(
              'span[class="sapUshellAppTitle sapUshellAppTitleClickable"]')));
    } catch (e) {
      print(e);
    }
    return browser;
  }

  @override
  Future<bool> is_logged_in(Online browser) async {
    Show.action('checking', 'if', username, 'is logged in');
    try {
      await browser
          .visit(
              "https://cbs.almansoori.biz/sap/bc/gui/sap/its/webgui/?sap-client=800")
          // .wait(Waitable.PageLoaded())
          .wait(
            Waitable.Element(WithId('ToolbarOkCode'),
                timeout: Duration(seconds: 5)),
          );
      Show.success("already logged in as", username);
      return true;
    } catch (e) {
      Show.warning("not logged in as", username);
      return false;
    }
  }
}

class SapFiori implements AbstractUrl {
  String get url =>
      'https://cbs.almansoori.biz/sap/bc/ui5_ui5/ui2/ushell/shells/abap/FioriLaunchpad.html?sap-client=800&sap-language=EN';
  const SapFiori();
}

class SapTransactionUrl implements AbstractUrl {
  final String code;
  String get url =>
      'https://cbs.almansoori.biz/sap/bc/gui/sap/its/webgui/?sap-client=800&~TRANSACTION=$code#';
  const SapTransactionUrl(this.code);
}

/// For example.
/// the code for
/// Header release Service PR is ZPRS
/// Header release Rental PR is ZPRR
/// Header release Opex PR is ZPRO
class SapPurchaseRequestUrl implements AbstractUrl {
  /// Header release Service PR is ZPRS
  /// Header release Rental PR is ZPRR
  /// Header release Opex PR is ZPRO
  final String code;
  String get url =>
      'https://cbs.almansoori.biz/sap/bc/gui/sap/its/webgui/?sap-client=800&~TRANSACTION=*ME51N MEREQ_TOPLINE-BSART=$code#';

  /// Header release Service PR is ZPRS
  /// Header release Rental PR is ZPRR
  /// Header release Opex PR is ZPRO
  const SapPurchaseRequestUrl(this.code);
}
