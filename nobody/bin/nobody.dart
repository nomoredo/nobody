import 'package:nobody/references.dart';

void main(List<String> arguments) async {
  await export_emp_attendance();
}

Future export_emp_attendance() async {
  return create_pr();
}

const String lsdata_prefix =
    "wnd[0]/usr/subSUB0:SAPLMEGUI:0019/subSUB3:SAPLMEVIEWS:1100/subSUB2:SAPLMEVIEWS:1200/subSUB1:SAPLMEGUI:1301/subSUB2:SAPLMEGUI:3303/tabsREQ_ITEM_DETAIL/tabpTABREQDT1/ssubTABSTRIPCONTROL1SUB:SAPLMEGUI:1328/subSUB0:SAPLMLSP:0400/tblSAPLMLSPTC_VIEW";
const prline_prefix =
    'wnd[0]/usr/subSUB0:SAPLMEGUI:0016/subSUB2:SAPLMEVIEWS:1100/subSUB2:SAPLMEVIEWS:1200/subSUB1:SAPLMEGUI:3212/cntlGRIDCONTROL/shellcont/shell/rowcol';

typedef OnlineAction = Future<Online> Function(Online browser);
typedef CollectData<T> = T? Function(Online browser);
typedef Validation = Future<ValidationResponse> Function(Online browser);

abstract class SimpleInput<T> {
  bool mandatory;
  OnlineAction? prepare_action;
  OnlineAction? cleanup_action;
  Validation? validate_action;
  OnlineAction? submit_action;
  CollectData<T>? collect_data;

  SimpleInput(
      {this.mandatory = true,
      this.prepare_action,
      this.cleanup_action,
      this.validate_action,
      this.submit_action,
      this.collect_data});

  Future<Online> fill(Online browser, T value) async {
    if (prepare_action != null) {
      await prepare_action!.call(browser);
    }

    if (collect_data != null && value == null && mandatory) {
      value = collect_data!.call(browser)!;
    }

    await fill_action(browser, value);

    if (validate_action != null) {
      final response = await validate_action!(browser);
      if (!response.valid) {
        throw Exception(response.message);
      } else {
        Show.success("validation successfull", response.message ?? "");
      }

      if (submit_action != null) {
        Show.step("submitting", "form");
        await submit_action!.call(browser);
      }
    }

    if (cleanup_action != null) {
      await cleanup_action!.call(browser);
    }
    return browser;
  }

  Future<Online> fill_action(Online browser, T value);

  //set before action
  SimpleInput<T> prepare(OnlineAction before) {
    this.prepare_action = before;
    return this;
  }

  //set after action
  SimpleInput<T> cleanup(OnlineAction after) {
    this.cleanup_action = after;
    return this;
  }

  SimpleInput<T> submit(OnlineAction submit) {
    this.submit_action = submit;
    return this;
  }

  SimpleInput<T> collect(CollectData<T> collect) {
    this.collect_data = collect;
    return this;
  }

  //set validation action
  SimpleInput<T> validate(Validation validate) {
    this.validate_action = validate;
    return this;
  }
}

class ValidationResponse {
  final bool valid;
  final String? message;
  ValidationResponse(this.valid, {this.message});
}

class NoTextBox extends SimpleInput<String> {
  final AbstractSelector selector;

  NoTextBox(this.selector,
      {super.prepare_action,
      super.cleanup_action,
      super.validate_action,
      super.submit_action,
      super.collect_data,
      super.mandatory = true});

  @override
  Future<Online> fill_action(Online browser, dynamic value) {
    final selected = browser.type(selector, value);
    return selected;
  }
}

class NoButton extends SimpleInput<void> {
  final AbstractSelector selector;

  NoButton(this.selector,
      {super.prepare_action,
      super.cleanup_action,
      super.validate_action,
      super.submit_action,
      super.collect_data,
      super.mandatory = true});

  @override
  Future<Online> fill_action(Online browser, dynamic value) {
    final selected = browser.click(selector);
    return selected;
  }
}

class NoMaybeButton extends SimpleInput<void> {
  final AbstractSelector selector;

  NoMaybeButton(this.selector,
      {super.prepare_action,
      super.cleanup_action,
      super.validate_action,
      super.submit_action,
      super.collect_data,
      super.mandatory = false});

  @override
  Future<Online> fill_action(Online browser, dynamic value) async {
    final selected = await browser.maybe_click(selector);
    return selected;
  }
}

class NoSapGridElement extends SimpleInput<String> {
  final AbstractSelector selector;

  NoSapGridElement(this.selector,
      {super.prepare_action,
      super.cleanup_action,
      super.validate_action,
      super.submit_action,
      super.collect_data,
      super.mandatory = true});

  @override
  Future<Online> fill_action(Online browser, dynamic value) async {
    await browser.click(selector);
    final selected =
        await (await browser.page).waitForSelector(selector.selector);
    if (selected != null) {
      final internal = await selected.$('input');
      await internal.type(value.toString());
      await browser.press(Key.tab);
    }

    return browser;
  }
}

class NoForm extends SimpleInput<Map<String, Object>> {
  Map<String, SimpleInput> fields;

  NoForm(
      {Map<String, SimpleInput>? fields,
      super.prepare_action,
      super.cleanup_action,
      super.validate_action,
      super.submit_action,
      super.collect_data,
      super.mandatory = true})
      : fields = fields ?? {};

  @override
  Future<Online> fill_action(Online browser, Map<String, Object> values) async {
    for (var field in fields.keys) {
      if (values[field] == null && fields[field]!.mandatory) {
        values[field] = await collect_data!.call(browser)!;
      }
    }

    for (var field in fields.keys) {
      await fields[field]!.fill_action(browser, values[field]);
    }

    return browser;
  }

  // @override
  // Future<Online> fill_action(Online browser, Map<String, Object> values) async {
  //   // await prepare_action?.call(browser);

  //   if (collect_data != null) {
  //     for (var field in fields.keys) {
  //       if (values[field] == null && fields[field]!.mandatory) {
  //         values[field] = await collect_data!.call(browser)!;
  //       }
  //     }
  //   }

  //   for (var field in fields.keys) {
  //     await fields[field]!.fill_action(browser, values[field]);
  //   }

  //   Show.step("validating", "form");
  //   if (validate_action != null) {
  //     final response = await validate_action!(browser);
  //     if (!response.valid) {
  //       throw Exception(response.message);
  //     } else {
  //       Show.success("validation successfull", response.message ?? "");
  //       Show.step("submitting", "form");
  //       await submit_action?.call(browser);
  //     }
  //   }

  //   Show.step("cleaning up", "after work");
  //   await cleanup_action?.call(browser);

  //   return browser;
  // }
}

class MultiForm extends SimpleInput<List<Map<String, Object>>> {
  final NoForm form;

  MultiForm(this.form,
      {super.prepare_action,
      super.cleanup_action,
      super.validate_action,
      super.submit_action,
      super.collect_data,
      super.mandatory = true});

  @override
  Future<Online> fill_action(
      Online browser, List<Map<String, Object>> values) async {
    for (var value in values) {
      await prepare_action?.call(browser);
      await form.fill_action(browser, value);
      await cleanup_action?.call(browser);
    }
    return browser;
  }
}

class SapTransaction extends NoForm {
  SapTransaction(
      {Map<String, SimpleInput>? fields,
      super.prepare_action,
      super.cleanup_action,
      super.validate_action,
      super.submit_action,
      super.collect_data,
      super.mandatory = true})
      : super(
          fields: fields,
        );

  factory SapTransaction.builder() {
    return SapTransaction();
  }

  SapTransaction with_textbox(String field,
      {AbstractSelector? selector,
      String? lsdata,
      String? id,
      String? name,
      String? xpath,
      String? css,
      String? tag,
      String? className}) {
    if (selector == null) {
      if (lsdata != null) {
        selector = SapDataField(lsdata);
      } else if (id != null) {
        selector = WithId(id);
      } else if (name != null) {
        selector = WithName(name);
      } else if (xpath != null) {
        selector = XPath(xpath);
      } else if (css != null) {
        selector = Css(css);
      }
    }

    if (selector == null) {
      throw Exception("No selector provided");
    }

    this.fields[field] = NoTextBox(selector);
    return this;
  }

  SapTransaction grid_cell(String field,
      {AbstractSelector? selector,
      String? lsdata,
      String? id,
      String? name,
      String? xpath,
      String? css,
      String? tag,
      String? className,
      OnlineAction? before,
      OnlineAction? after}) {
    if (selector == null) {
      if (lsdata != null) {
        selector = SapDataField(lsdata);
      } else if (id != null) {
        selector = WithId(id);
      } else if (name != null) {
        selector = WithName(name);
      } else if (xpath != null) {
        selector = XPath(xpath);
      } else if (css != null) {
        selector = Css(css);
      }
    }

    if (selector == null) {
      throw Exception("No selector provided");
    }

    this.fields[field] = NoSapGridElement(selector,
        prepare_action: before, cleanup_action: after);
    return this;
  }

  @override
  SapTransaction prepare(OnlineAction before) {
    super.prepare(before);
    return this;
  }

  @override
  SapTransaction cleanup(OnlineAction after) {
    super.cleanup(after);
    return this;
  }

  @override
  SapTransaction submit(OnlineAction submit) {
    super.submit(submit);
    return this;
  }

  @override
  SapTransaction collect(CollectData<Map<String, Object>> collect) {
    super.collect(collect);
    return this;
  }

  @override
  SapTransaction validate(Validation validate) {
    super.validate(validate);
    return this;
  }

  SapTransaction maybe_click(String field,
      {AbstractSelector? selector,
      String? lsdata,
      String? id,
      String? name,
      String? xpath,
      String? css,
      String? tag,
      String? className}) {
    if (selector == null) {
      if (lsdata != null) {
        selector = SapDataField(lsdata);
      } else if (id != null) {
        selector = WithId(id);
      } else if (name != null) {
        selector = WithName(name);
      } else if (xpath != null) {
        selector = XPath(xpath);
      } else if (css != null) {
        selector = Css(css);
      }
    }

    if (selector == null) {
      throw Exception("No selector provided");
    }

    this.fields[field] = NoMaybeButton(selector);
    return this;
  }

  SapTransaction many(
      String field, NoForm Function(SapTransaction builder) builder,
      {OnlineAction? before, OnlineAction? after}) {
    this.fields[field] = MultiForm(builder(SapTransaction.builder()),
        prepare_action: before, cleanup_action: after);

    return this;
  }
}

Future create_pr() async {
  SapTransaction create_service_pr = SapTransaction.builder()
      .prepare((x) =>
          x.login(Sap.User('amohandas')).goto(SapPurchaseRequest("ZPRS")))
      .with_textbox("header", lsdata: "cntlTEXT_EDITOR_0101/shellcont/shell")
      .maybe_click("maybe expand section",
          css: 'div[role="button"][title="Expand Items Ctrl+F3"]')
      .many("lineItems", (SapTransaction builder) {
    return builder
        .grid_cell("account_assignment", lsdata: "rowcol/row[1]/cell[1]")
        .grid_cell("description", lsdata: "rowcol/row[1]/cell[4")
        .grid_cell("expense_type", lsdata: "rowcol/row[1]/cell[2]")
        .grid_cell("quantity", lsdata: "rowcol/row[1]/cell[5]")
        .grid_cell("unit", lsdata: "rowcol/row[1]/cell[6]")
        .grid_cell("material_type", lsdata: "rowcol/row[1]/cell[9]")
        .grid_cell("price", lsdata: "rowcol/row[1]/cell[10]")
        .grid_cell("currency", lsdata: "rowcol/row[1]/cell[11]")
        .grid_cell("tracking", lsdata: "rowcol/row[1]/cell[12]")
        .many("serviceItems", (SapTransaction builder) {
      return builder
          // .prepare((x) => x.press(Key.enter))
          .grid_cell("serviceCode", lsdata: "ctxtESLL-SRVPOS[2,0]")
          .grid_cell("description", lsdata: "txtESLL-KTEXT1[3,0]")
          .grid_cell("quantity", lsdata: "txtESLL-MENGE[4,0]")
          .grid_cell("unit", lsdata: "ctxtESLL-MEINS[5,0]")
          .grid_cell("wbs", lsdata: "ctxtRM11P-PS_PSP_PNR[6,0]")
          .grid_cell("price", lsdata: "txtESLL-TBTWR[7,0]");
    }, before: (x) => x.press(Key.enter));
  });

  create_service_pr.validate((browser) async {
    final msg = await browser
        .click(Sap.Button("Check (Ctrl+Shift+F3)"))
        .wait(Waitable.Seconds(2))
        .get_element(WithId('wnd[0]/sbar_msg-txt'));
    final title = await msg?.get_value();
    if (title != null && title.contains("No messages issued during check"))
      return ValidationResponse(true, message: title);

    return ValidationResponse(false, message: title);
  });

  var browser = await Nobody().online();

  await create_service_pr.fill(browser, {
    "header": "this is a header text",
    "lineItems": [
      {
        "account_assignment": "P",
        "expense_type": "D",
        "description": "TEST SERVICE DESCRIPTION",
        "quantity": 1,
        "unit": "EA",
        "price": 0.01,
        "currency": "AED",
        "tracking": "trking",
        "material_type": "SERVICE",
        "serviceItems": [
          {
            "serviceCode": "1000000438",
            "description": "TEST DESCRIPTION",
            "quantity": "1",
            "unit": "EA",
            "price": "0.01",
            "currency": "AED",
            "wbs": "MWS-AE-0017.01.001",
          }
        ]
      }
    ]
  });
}

// // create PR
// Future create_pr() async {
//   final pr = ServicePurchaseRequest(
//     header: "this is a header text",
//     lineItems: [
//       ServicePrLineItem(
//           tracking: "trking",
//           account_assignment: "P",
//           expense_type: "D",
//           quantity: 1,
//           unit: "EA",
//           currency: "AED",
//           price: 0.01,
//           description: "TEST SERVICE DESCRIPTION",
//           serviceItems: [
//             ServiceLineItem(
//               serviceCode: "1000000438",
//               description: "TEST DESCRIPTION",
//               quantity: "1",
//               unit: "EA",
//               price: "0.01",
//               currency: "AED",
//               wbs: "MWS-AE-0017.01.001",
//             )
//           ]),
//     ],
//   );

//   var browser = await Nobody()
//       .online()
//       .login(Sap.User('amohandas'))
//       .goto(SapPurchaseRequest(pr.prType.code))
//       .maybe_click(Sap.Button("Expand Header Ctrl+F2"))
//       .set(Sap.Data('cntlTEXT_EDITOR_0101/shellcont/shell'), pr.header)
//       .maybe_click(Sap.Button("Collapse Header Ctrl+F5"));

//   for (int i = 0; i < pr.lineItems.length; i++) {
//     var item = pr.lineItems[i];
//     await browser
//         // account assignment
//         .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[2]'))
//         .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[2]'),
//             item.account_assignment)
//         // expense type
//         .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[3]'))
//         .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[3]'),
//             item.expense_type)
//         // description
//         .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[5]'))
//         .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[5]'),
//             item.description)
//         // quantity
//         .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[6]'))
//         .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[6]'),
//             item.quantity)
//         // unit
//         .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[7]'))
//         .set(
//             Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[7]'), item.unit)

//         // nothing
//         // .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[8]'))
//         // .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[8]'), "")

//         // //nothing
//         // .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[9]'))
//         // .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[9]'), "")
//         // .wait(Waitable.Seconds(10))
//         // material type

//         .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[10]'))
//         .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[10]'),
//             "SERVICE")
//         // price
//         .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[11]'))
//         .set(
//             Sap.InputForData('shell/rowcol/row[${i + 1}]/cell[11]'), item.price)
//         // currency
//         .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[12]'))
//         .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[12]'),
//             item.currency)
//         // tracking
//         .click(Sap.Data('$prline_prefix/row[${i + 1}]/cell[13]'))
//         .set(Sap.InputForData('$prline_prefix/row[${i + 1}]/cell[13]'),
//             item.tracking)
//         .press(Key.enter);

//     //   await browser  .set_grid_cell("C106", 1, 3,item.account_assignment)
//     // .set_grid_cell("C106", 1, 4,item.order)
//     // .set_grid_cell("C106", 1, 6,item.description)
//     // .set_grid_cell("C106", 1, 7,item.quantity)
//     // .set_grid_cell("C106", 1, 8,item.unit)
//     // .set_grid_cell("C106", 1, 10,item.pr_date)
//     // .set_grid_cell("C106", 1, 11,item.material_type)
//     // .set_grid_cell("C106", 1, 12,item.price)
//     // .set_grid_cell("C106", 1, 13,item.currency)
//     // .set_grid_cell("C106", 1, 14,item.tracking)
//     // .press(Key.enter);
//     var service_items = item.serviceItems;
//     for (int j = 0; j < service_items.length; j++) {
//       var item = service_items[j];
//       await browser
//           .wait(Waitable.Seconds(2))
//           .click(Sap.Data('$lsdata_prefix/ctxtESLL-SRVPOS[2,$j]'))
//           .set(Sap.InputWithData('$lsdata_prefix/ctxtESLL-SRVPOS[2,$j]'),
//               item.serviceCode)
//           .click(Sap.Data('$lsdata_prefix/txtESLL-KTEXT1[3,$j]'))
//           .set(Sap.InputWithData('$lsdata_prefix/txtESLL-KTEXT1[3,$j]'),
//               item.description)
//           .click(Sap.Data('$lsdata_prefix/txtESLL-MENGE[4,$j]'))
//           .set(Sap.InputWithData('$lsdata_prefix/txtESLL-MENGE[4,$j]'),
//               item.quantity)
//           .click(Sap.Data('$lsdata_prefix/ctxtESLL-MEINS[5,$j]'))
//           .set(Sap.InputWithData('$lsdata_prefix/ctxtESLL-MEINS[5,$j]'),
//               item.unit)
//           .click(Sap.Data('$lsdata_prefix/ctxtRM11P-PS_PSP_PNR[6,$j]'))
//           .set(Sap.InputWithData('$lsdata_prefix/ctxtRM11P-PS_PSP_PNR[6,$j]'),
//               item.wbs)
//           .click(Sap.Data('$lsdata_prefix/txtESLL-TBTWR[7,$j]'))
//           .set(Sap.InputWithData('$lsdata_prefix/txtESLL-TBTWR[7,$j]'),
//               item.price)
//           .press(Key.enter);
//     }
//   }

//   return browser.click(Sap.Button("Check")).wait(Waitable.Seconds(50)).close();
//   // .click(Div.WithId("M0:46:1:4:2:1:2:1::0:0"))
// }
