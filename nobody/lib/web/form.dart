import 'package:nobody/references.dart';

typedef OnlineAction = FutureOr Function(Online browser);
typedef CollectData<T> = T? Function(Online browser);
typedef Validation = FutureOr<ValidationResponse> Function(Online browser);

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

  Future<Online> fill(T value) async {
    final browser = await nobody.online();
    return fill_with(browser, value);
  }

  Future<Online> fill_with(Online browser, T value) async {
    Show.action("preparing", "to fill", value.toString());
    if (prepare_action != null) {
      await prepare_action!.call(browser);
    }

    Show.action("collecting", "input data");
    if (collect_data != null && value == null && mandatory) {
      value = collect_data!.call(browser)!;
    }

    Show.action("filling", "data");
    await fill_action(browser, value);

    Show.action("validating", "input");
    if (validate_action != null) {
      final response = await validate_action!(browser);
      if (!response.valid) {
        Show.error("validation failed", response.message ?? "");
      } else {
        Show.success("validation successfull", response.message ?? "");
        if (submit_action != null) {
          Show.step("submitting", "form");
          await submit_action!.call(browser);
        }
      }
    } else {
      if (submit_action != null) {
        Show.step("submitting", "form");
        await submit_action!.call(browser);
      }
    }

    if (cleanup_action != null) {
      Show.action("cleaning", "up");
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

  static ValidationResponse ShouldMatch(String? actual, String expected) {
    return ValidationResponse(actual == expected, message: actual);
  }
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
    await browser.click(selector, show: false);
    final selected =
        await (await browser.page).waitForSelector(selector.selector);
    if (selected != null) {
      final internal = await selected.$('input');
      await internal.type(value.toString());
      await browser.press(Key.tab, show: false);
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

  SapTransaction many(String field, Function(SapTransaction builder) builder,
      {OnlineAction? before, OnlineAction? after}) {
    this.fields[field] = MultiForm(builder(SapTransaction.builder()),
        prepare_action: before, cleanup_action: after);

    return this;
  }
}
