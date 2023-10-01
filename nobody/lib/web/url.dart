abstract class AbstractUrl {
  String get url;
}

class Transaction implements AbstractUrl {
  final String code;
  String get url =>
      'https://cbs.almansoori.biz/sap/bc/gui/sap/its/webgui/?sap-client=800&~TRANSACTION=$code#';
  const Transaction(this.code);
}

class Url implements AbstractUrl {
  final String url;
  const Url(this.url);
}

class SapFiori implements AbstractUrl {
  String get url =>
      'https://cbs.almansoori.biz/sap/bc/ui5_ui5/ui2/ushell/shells/abap/FioriLaunchpad.html?sap-client=800&sap-language=EN';
  const SapFiori();
}
