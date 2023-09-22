// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:nobody/references.dart';

abstract class Authable {
  AbstractUrl get url;
  String get username;
  AbstractPassword get password;
  Future<Online> login(Online browser);
}

class Sap implements Authable {
  final String username;
  AbstractPassword get password => Password.From(scope: 'sap', key: username);
  AbstractUrl get url => Url('https://cbs.almansoori.biz');

  const Sap(this.username);

  @override
  Future<Online> login(Online browser) async {
    var pss = await password.password;
    return browser
        .visit(url.url)
        .set(Input.WithId('logonuidfield'), username)
        .set(Input.WithId('logonpassfield'), pss)
        .click(Input.WithName('uidPasswordLogon'))
        .waitFor(Navigation)
        .waitFor(Seconds(5));
  }
}
