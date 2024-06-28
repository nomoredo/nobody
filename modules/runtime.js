const { core } = Deno;
const { ops } = core;

class Nobody {
  constructor() {
    this.chain = Promise.resolve();
  }

  init() {
    this.chain = this.chain.then(() => ops.op_init_browser().then(() => this));
    return this;
  }

  navigateTo(url) {
    this.chain = this.chain.then(() => ops.op_navigate_to(url).then(() => this));
    return this;
  }

  takeScreenshot(path) {
    this.chain = this.chain.then(() => ops.op_take_screenshot(path).then(() => this));
    return this;
  }

  click(selector) {
    this.chain = this.chain.then(() => ops.op_click(selector).then(() => this));
    return this;
  }

  getText(selector) {
    this.chain = this.chain.then(() => ops.op_get_text(selector));
    return this;
  }

  typeText(selector, text) {
    this.chain = this.chain.then(() => ops.op_type_text(selector, text).then(() => this));
    return this;
  }

  setTimeout(delay) {
    this.chain = this.chain.then(() => ops.op_set_timeout(delay).then(() => this));
    return this;
  }

  evaluate(script) {
    this.chain = this.chain.then(() => ops.op_evaluate(script));
    return this;
  }

  fillForm(selector, values) {
    this.chain = this.chain.then(() => ops.op_fill_form(selector, values).then(() => this));
    return this;
  }

  waitForElement(selector) {
    this.chain = this.chain.then(() => ops.op_wait_for_element(selector).then(() => this));
    return this;
  }

  selectOption(selector, value) {
    this.chain = this.chain.then(() => ops.op_select_option(selector, value).then(() => this));
    return this;
  }

  scroll(x, y) {
    this.chain = this.chain.then(() => ops.op_scroll(x, y).then(() => this));
    return this;
  }

  async exec() {
    return await this.chain;
  }
}

const nobody = new Nobody();
