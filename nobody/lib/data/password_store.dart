import 'dart:convert';

import 'package:nobody/data/store.dart';

final passwordStore = Store<String>(
  storeName: 'passwords',
  deserialize: (bytes) => aesDecrypt(base64.encode(bytes), key),
  serialize: (value) => base64.decode(aesEncrypt(value, key)),
);

final tokenStore = Store<String>(
  storeName: 'tokens',
  deserialize: (bytes) => aesDecrypt(base64.encode(bytes), key),
  serialize: (value) => base64.decode(aesEncrypt(value, key)),
);

final dateStore = Store<DateTime>(
  storeName: 'dates',
  deserialize: (bytes) => DateTime.fromMillisecondsSinceEpoch(
      int.parse(String.fromCharCodes(bytes))),
  serialize: (value) => value.millisecondsSinceEpoch.toString().codeUnits,
);
