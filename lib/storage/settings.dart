import 'package:shared_preferences/shared_preferences.dart';

abstract class Settings {
  Future<bool> save(String key, String value);

  Future<String?> get(String key);

  Future<bool> containsKey(String key);

  Future<void> remove(String key);
}

class SettingsImpl extends Settings {
  SharedPreferences? _preferences;

  Future<SharedPreferences> _getPreferences() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _preferences!;
  }

  @override
  Future<String?> get(String key) async {
    var preferences = await _getPreferences();
    var value = preferences.get(key);
    if (value == null)
      return null;
    else
      return value as String;
  }

  @override
  Future<bool> containsKey(String key) async {
    return (await _getPreferences()).containsKey(key);
  }

  @override
  Future<bool> save(String key, String value) async {
    var preferences = await _getPreferences();
    return preferences.setString(key, value);
  }

  @override
  Future<void> remove(String key) async {
    var preferences = await _getPreferences();
    await preferences.remove(key);
  }
}
