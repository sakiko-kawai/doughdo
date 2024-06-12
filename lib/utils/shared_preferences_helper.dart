import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  static SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) return _prefs!;
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> saveString(String name, String value) async {
    await _prefs!.setString(name, value);
  }

  Future<void> saveInt(String name, int value) async {
    await _prefs!.setInt(name, value);
  }

  String getString(String key) {
    return _prefs!.getString(key) ?? "0";
  }

  int? getInt(String key) {
    return _prefs!.getInt(key);
  }

  void clear() async {
    await _prefs!.clear();
  }

  void remove(String key) async {
    await _prefs!.remove(key);
  }
}
