// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:nobody/references.dart';

abstract class Authable {
  AbstractUrl get url;
  String get username;
  AbstractPassword get password;
  Future<Online> login(Online browser);
}

