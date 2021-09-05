import 'package:hive_flutter/adapters.dart';

part 'Account.g.dart';

@HiveType(typeId: 1)
class Account {
  Account({required this.username});

  @HiveField(0)
  String username;
}
