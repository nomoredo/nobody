import 'package:nobody/references.dart';

extension ElementExt on ElementHandle? {
  Future<String?> get_title() async {
    if (this == null) return null;
    return await this!.propertyValue('title');
  }

  Future<String?> get_text() async {
    if (this == null) return null;
    return await this!.propertyValue('text');
  }

  Future<String?> get_id() async {
    if (this == null) return null;
    return await this!.propertyValue('id');
  }

  Future<String?> get_name() async {
    if (this == null) return null;
    return await this!.propertyValue('name');
  }

  Future<String?> get_value() async {
    if (this == null) return null;
    //get inner html
    final value = await this!.evaluate('(el) => el.innerHTML');
    return value as String?;
  }
}

extension ElementFutureExt on Future<ElementHandle?> {
  Future<String?> get_title() async {
    final element = await this;
    return await element?.get_title();
  }

  Future<String?> get_text() async {
    final element = await this;
    return await element?.get_text();
  }

  Future<String?> get_id() async {
    final element = await this;
    return await element?.get_id();
  }

  Future<String?> get_name() async {
    final element = await this;
    return await element?.get_name();
  }

  Future<String?> get_value() async {
    final element = await this;
    return await element?.get_value();
  }
}

extension FutureMapExt<T> on Future<T> {
  Future<R> map<R>(R Function(T) f) async {
    return f(await this);
  }
}
