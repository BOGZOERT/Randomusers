import 'package:hive_flutter/hive_flutter.dart';
import 'package:randomusers/storage/account/Account.dart';

abstract class HiveStorage {
  Future<Box> accounts();
}

class HiveStorageImpl extends HiveStorage {
  HiveStorageImpl() {
    Hive
      ..initFlutter()
      ..registerAdapter(AccountAdapter());
  }

  @override
  Future<Box> accounts() async {
    if (!Hive.isBoxOpen(_accountsBox)) {
      await Hive.openBox(_accountsBox);
    }

    return Hive.box(_accountsBox);
  }

  final String _accountsBox = 'accounts';
}
