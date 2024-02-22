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
