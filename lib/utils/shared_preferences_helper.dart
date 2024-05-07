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

  Future<void> save(String name, String value) async {
    await _prefs!.setString(name, value);
  }

  String get(String key) {
    return _prefs!.getString(key) ?? "0";
  }
}
