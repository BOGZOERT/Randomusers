import 'package:randomusers/storage/account/Account.dart';
import 'package:randomusers/storage/settings.dart';
import 'package:randomusers/storage/settings_keys.dart';
import 'package:randomusers/storage/storage.dart';
import 'package:randomusers/storage/storage_keys.dart';

abstract class AuthRepository {
  Future<void> login(String username);

  Future<bool> isAuthorized();
  Future<String?> username();

  static AuthRepository create({
    required HiveStorage storage,
    required Settings settings,
  }) {
    return _AuthRepositoryImpl(storage, settings);
  }
}

class _AuthRepositoryImpl extends AuthRepository {
  final HiveStorage _storage;
  final Settings _settings;

  _AuthRepositoryImpl(this._storage, this._settings);

  @override
  Future<void> login(String username) async {
    var accounts = await _storage.accounts();
    accounts.put(StorageKeys.username, Account(username: username));
    _settings.save(SettingsKey.authUsername, username);
  }

  @override
  Future<bool> isAuthorized() async {
    return await _settings.containsKey(SettingsKey.authUsername);
  }

  @override
  Future<String?> username() async {
    return await _settings.get(SettingsKey.authUsername);
  }
}
