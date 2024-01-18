import 'package:nobody/lib.dart';

void main() async {
  await check_email();
}

Future check_email() async {
  return await Nobody()
      .at_office('amohandas')
      .read_mails()
      .with_subject('test')
      .from('amohandas')
      .get();
}
