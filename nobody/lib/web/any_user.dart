// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:nobody/references.dart';

import 'any_password.dart';
import 'any_url.dart';

abstract class AnyUser {
  AnyUrl get url;
  String get username;
  AnyPassword get password;
  Future<Online> login(Online browser);
}
