// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:nobody/references.dart';

abstract class AnyPassword {
  Future<String> get password;

  factory AnyPassword.From({required String scope, required String key}) {
    return Password(scope: scope, key: key);
  }

  Future<bool> save(String password);

  @override
  String toString() {
    return 'P*SSW*RD';
  }
}
