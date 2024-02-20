import 'package:nobody/references.dart';

void main(List<String> arguments) async {
  await export_emp_attendance();
}

Future export_emp_attendance() async {
  return create_pr();
}

enum PrType {
  Service,
  Rental,
  Opex,
  Capex,
  Stock,
  Asset,
  Material,
}

extension PrTypeExtension on PrType {
  String get code {
    switch (this) {
      case PrType.Service:
        return "ZPRS";
      case PrType.Rental:
        return "ZPRR";
      case PrType.Opex:
        return "ZPRO";
      case PrType.Capex:
        return "ZPRC";
      case PrType.Stock:
        return "ZPRK";
      case PrType.Asset:
        return "ZPRA";
      case PrType.Material:
        return "ZPRM";
      default:
        throw Exception('Unknown PrType: $this');
    }
  }
}

// Base class for a PR line item
abstract class PrLineItem {
  final String? tracking;
  final String? account_assignment;
  final String? expense_type;
  final double quantity;
  final String unit;
  final String currency;
  final double? price;

  PrLineItem({
    required this.tracking,
    required this.account_assignment,
    required this.expense_type,
    required this.quantity,
    required this.unit,
    required this.currency,
    required this.price,
  });
}

// Specialized class for Service PR line items
class ServicePrLineItem extends PrLineItem {
  final String description;
  final List<ServiceLineItem> serviceItems;

  ServicePrLineItem({
    required String tracking,
    required String account_assignment,
    required String expense_type,
    required double quantity,
    required String unit,
    required String currency,
    required double price,
    required this.description,
    required this.serviceItems,
  }) : super(
          tracking: tracking,
          account_assignment: account_assignment,
          expense_type: expense_type,
          quantity: quantity,
          unit: unit,
          currency: currency,
          price: price,
        );
}

// Class for Service Line Items
class ServiceLineItem {
  final String serviceCode;
  final String? description;
  final String? quantity;
  final String? unit;
  final String? price;
  final String? currency;
  final String? wbs;
  final String? costCenter;
  final String? order;

  const ServiceLineItem({
    required this.serviceCode,
    this.description,
    this.quantity,
    this.unit,
    this.price,
    this.currency,
    this.wbs,
    this.costCenter,
    this.order,
  }) // either wbs/costCenter/order should be present
  : assert(wbs != null || costCenter != null || order != null);
}

// Generic PurchaseRequest class to handle different types of PRs
class PurchaseRequest<T extends PrLineItem> {
  final String header;
  final PrType prType;
  final List<T> lineItems;

  const PurchaseRequest({
    required this.header,
    required this.prType,
    required this.lineItems,
  });
}

// Specialization for Service Purchase Requests
class ServicePurchaseRequest extends PurchaseRequest<ServicePrLineItem> {
  ServicePurchaseRequest({
    required String header,
    required List<ServicePrLineItem> lineItems,
  }) : super(header: header, prType: PrType.Service, lineItems: lineItems);
}

const String lsdata_prefix =
    "wnd[0]/usr/subSUB0:SAPLMEGUI:0019/subSUB3:SAPLMEVIEWS:1100/subSUB2:SAPLMEVIEWS:1200/subSUB1:SAPLMEGUI:1301/subSUB2:SAPLMEGUI:3303/tabsREQ_ITEM_DETAIL/tabpTABREQDT1/ssubTABSTRIPCONTROL1SUB:SAPLMEGUI:1328/subSUB0:SAPLMLSP:0400/tblSAPLMLSPTC_VIEW";
const prline_prefix =
    'wnd[0]/usr/subSUB0:SAPLMEGUI:0016/subSUB2:SAPLMEVIEWS:1100/subSUB2:SAPLMEVIEWS:1200/subSUB1:SAPLMEGUI:3212/cntlGRIDCONTROL/shellcont/shell/rowcol';

// create PR
Future create_pr() async {
  final pr = ServicePurchaseRequest(
    header: "this is a header text",
    lineItems: [
      ServicePrLineItem(
          tracking: "trking",
          account_assignment: "P",
          expense_type: "D",
          quantity: 1,
          unit: "EA",
          currency: "AED",
          price: 0.01,
          description: "TEST SERVICE DESCRIPTION",
          serviceItems: [
            ServiceLineItem(
              serviceCode: "1000000438",
              description: "TEST DESCRIPTION",
              quantity: "1",
              unit: "EA",
              price: "0.01",
              currency: "AED",
              wbs: "MWS-AE-0017.01.001",
            )
          ]),
    ],
  );

  var browser = await Nobody()
      .online()
      .login(Sap.User('amohandas'))
      .goto(SapPurchaseRequest(pr.prType.code))
      .maybe_click(Sap.Button("Expand Header Ctrl+F2"))
      .set(Sap.Data('cntlTEXT_EDITOR_0101/shellcont/shell'), pr.header)
      .maybe_click(Sap.Button("Collapse Header Ctrl+F5"));

  for (int i = 0; i < pr.lineItems.length; i++) {
    var item = pr.lineItems[i];
    await browser
        // account assignment
        .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[2]'))
        .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[2]'),
            item.account_assignment)
        // expense type
        .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[3]'))
        .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[3]'),
            item.expense_type)
        // description
        .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[5]'))
        .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[5]'),
            item.description)
        // quantity
        .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[6]'))
        .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[6]'),
            item.quantity)
        // unit
        .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[7]'))
        .set(
            Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[7]'), item.unit)

        // nothing
        // .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[8]'))
        // .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[8]'), "")

        // //nothing
        // .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[9]'))
        // .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[9]'), "")
        // .wait(Waitable.Seconds(10))
        // material type

        .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[10]'))
        .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[10]'),
            "SERVICE")
        // price
        .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[11]'))
        .set(
            Sap.InputForData('shell/rowcol/row[${i + 1}]/cell[11]'), item.price)
        // currency
        .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[12]'))
        .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[12]'),
            item.currency)
        // tracking
        .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[13]'))
        .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[13]'),
            item.tracking)
        .press(Key.enter);

    //   await browser  .set_grid_cell("C106", 1, 3,item.account_assignment)
    // .set_grid_cell("C106", 1, 4,item.order)
    // .set_grid_cell("C106", 1, 6,item.description)
    // .set_grid_cell("C106", 1, 7,item.quantity)
    // .set_grid_cell("C106", 1, 8,item.unit)
    // .set_grid_cell("C106", 1, 10,item.pr_date)
    // .set_grid_cell("C106", 1, 11,item.material_type)
    // .set_grid_cell("C106", 1, 12,item.price)
    // .set_grid_cell("C106", 1, 13,item.currency)
    // .set_grid_cell("C106", 1, 14,item.tracking)
    // .press(Key.enter);
    var service_items = item.serviceItems;
    for (int j = 0; j < service_items.length; j++) {
      var item = service_items[j];
      await browser
          .wait(Waitable.Seconds(2))
          .click(Sap.Data('$lsdata_prefix/ctxtESLL-SRVPOS[2,$j]'))
          .set(Sap.InputWithData('$lsdata_prefix/ctxtESLL-SRVPOS[2,$j]'),
              item.serviceCode)
          .click(Sap.Data('$lsdata_prefix/txtESLL-KTEXT1[3,$j]'))
          .set(Sap.InputWithData('$lsdata_prefix/txtESLL-KTEXT1[3,$j]'),
              item.description)
          .click(Sap.Data('$lsdata_prefix/txtESLL-MENGE[4,$j]'))
          .set(Sap.InputWithData('$lsdata_prefix/txtESLL-MENGE[4,$j]'),
              item.quantity)
          .click(Sap.Data('$lsdata_prefix/ctxtESLL-MEINS[5,$j]'))
          .set(Sap.InputWithData('$lsdata_prefix/ctxtESLL-MEINS[5,$j]'),
              item.unit)
          .click(Sap.Data('$lsdata_prefix/ctxtRM11P-PS_PSP_PNR[6,$j]'))
          .set(Sap.InputWithData('$lsdata_prefix/ctxtRM11P-PS_PSP_PNR[6,$j]'),
              item.wbs)
          .click(Sap.Data('$lsdata_prefix/txtESLL-TBTWR[7,$j]'))
          .set(Sap.InputWithData('$lsdata_prefix/txtESLL-TBTWR[7,$j]'),
              item.price)
          .press(Key.enter);
    }
  }

  return browser.click(Sap.Button("Check")).wait(Waitable.Seconds(50)).close();
  // .click(Div.WithId("M0:46:1:4:2:1:2:1::0:0"))
}

//create time report
Future create_time_report() async {
  return Nobody()
      .online()
      .login(Sap.User('amohandas'))
      .goto(SapTransaction("ZHR076A"))
      // .artificial_delay()
      .set(Sap.Input("Personnel Number"), "9711068")
      .set(Input.WithId("M0:46:::2:34"), "01.01.2023")
      .set(Input.WithId("M0:46:::2:59"), "01.01.2024")
      .click(Sap.Execute)
      .download(Sap.DownloadableTable, AbstractPath.Relative("attendance.xlsx"))
      .wait(Waitable.Seconds(50)) // this was for testing
      .close();
}
