// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:nobody/references.dart';

class Password implements AbstractPassword {
  final String scope;
  final String key;

  const Password({required this.scope, required this.key});

  factory Password.From({required String scope, required String key}) {
    return Password(scope: scope, key: key);
  }

  @override
  Future<String> get password async {
    var pss = await passwordStore.get('$scope.$key');
    if (pss == null) {
      return await requestPassword();
    } else {
      return pss;
    }
  }

  Future<String> requestPassword() async {
    var pss = await Ask.password(scope, key);
    await save(pss);
    return pss;
  }

  @override
  Future<bool> save(String password) async {
    await passwordStore.set('$scope.$key', password);
    return true;
  }
}

abstract class AbstractPassword {
  Future<String> get password;

  factory AbstractPassword.From({required String scope, required String key}) {
    return Password(scope: scope, key: key);
  }

  Future<bool> save(String password);

  @override
  String toString() {
    return 'P*SSW*RD';
  }
}
