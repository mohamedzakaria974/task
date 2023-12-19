import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';

class SharedPreferences {
  final logger = Logger('SharedPreferences');
  final Box<dynamic> storage;
  final Box<dynamic> securedStorage;

  SharedPreferences(this.storage, this.securedStorage);

  Future<void> _write(String key, String value, {bool secure = false}) async {
    Box<dynamic> tempStorage = storage;
    if (secure) {
      tempStorage = securedStorage;
    }
    await tempStorage
        .put(key, value)
        .catchError((error) => {logger.severe(error)});
  }

  String? _read(String key, {bool secure = false}) {
    Box<dynamic> tempStorage = storage;
    if (secure) {
      tempStorage = securedStorage;
    }
    return tempStorage.get(key);
  }

  String? getString(String key, {bool secure = false}) {
    return _read(key, secure: secure);
  }

  int? getInt(String key, {bool secure = false}) {
    try {
      final value = _read(key, secure: secure);
      if (value != null) {
        return int.parse(value);
      }
      return null;
    } catch (error) {
      //In case the value can't be cast
      logger.severe(error);
      return null;
    }
  }

  bool? getBool(String key, {bool secure = false}) {
    try {
      final value = _read(key, secure: secure);
      if (value != null) {
        return value.toLowerCase() == 'true';
      }
      return null;
    } catch (error) {
      logger.severe(error);
      return null;
    }
  }

  double? getDouble(String key, {bool secure = false}) {
    try {
      final value = _read(key, secure: secure);
      if (value != null) {
        return double.parse(value);
      }
      return null;
    } catch (error) {
      logger.severe(error);
      return null;
    }
  }

  Future<void> setString(String key, String value,
      {bool secure = false}) async {
    return await _write(key, value, secure: secure);
  }

  Future<void> setInt(String key, int value, {bool secure = false}) async {
    try {
      return await _write(key, value.toString(), secure: secure);
    } catch (error) {
      logger.severe(error);
    }
  }

  Future<void> setBool(String key, bool value, {bool secure = false}) async {
    try {
      return await _write(key, value.toString(), secure: secure);
    } catch (error) {
      logger.severe(error);
    }
  }

  Future<void> setDouble(String key, double value,
      {bool secure = false}) async {
    try {
      return await _write(key, value.toString(), secure: secure);
    } catch (error) {
      logger.severe(error);
    }
  }

  Future<void> delete(String key, {bool secure = false}) async {
    Box<dynamic> tempStorage = storage;
    if (secure) {
      tempStorage = securedStorage;
    }
    await tempStorage.delete(key).catchError((error) {
      logger.severe(error);
    });
  }

  Future<void> deleteAll({bool secure = false}) async {
    Box<dynamic> tempStorage = storage;
    if (secure) {
      tempStorage = securedStorage;
    }
    await tempStorage.clear().catchError((error) {
      logger.severe(error);
      return -10000; // no meaning
    });
  }

  Future<bool> containsKey(String key, {bool secure = false}) async {
    Box<dynamic> tempStorage = storage;
    if (secure) {
      tempStorage = securedStorage;
    }
    return tempStorage.containsKey(key);
  }
}
