import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

IOSOptions _getIOSOptions() => const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    );

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

Future<Box<dynamic>> initSecuredHiveBox() async {
  String? key;
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  key = await secureStorage.read(
    key: 'key',
    iOptions: _getIOSOptions(),
    aOptions: _getAndroidOptions(),
  );

  if (key == null) {
    await secureStorage.write(
      key: 'key',
      value: base64UrlEncode(Hive.generateSecureKey()),
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  final encryptionKey = base64Url.decode(await secureStorage.read(
        key: 'key',
        aOptions: _getAndroidOptions(),
        iOptions: _getIOSOptions(),
      ) ??
      '');

  return await Hive.openBox(
    'securedStorage',
    encryptionCipher: HiveAesCipher(encryptionKey),
  );
}
