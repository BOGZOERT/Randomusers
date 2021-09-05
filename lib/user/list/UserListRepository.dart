import 'package:randomusers/api/RandomUserApi.dart';
import 'package:randomusers/api/entity/UserNM.dart';
import 'package:randomusers/storage/entity/UserSM.dart';
import 'package:randomusers/storage/settings.dart';
import 'package:randomusers/storage/settings_keys.dart';

abstract class UserListRepository {
  Future<String?> username();

  Future<void> logout();

  Future<List<UserSM>> loadUsersList();
}

class UserListRepositoryImpl extends UserListRepository {
  final Settings settings;
  final RandomUserApi api;

  UserListRepositoryImpl({
    required this.settings,
    required this.api,
  });

  @override
  Future<String?> username() async {
    return await settings.get(SettingsKey.authUsername);
  }

  @override
  Future<void> logout() async {
    await settings.remove(SettingsKey.authUsername);
  }

  @override
  Future<List<UserSM>> loadUsersList() async {
    var networkModels = await api.getUsersList();
    print(networkModels);
    if (networkModels.isEmpty) {
      throw Exception("Nothing loaded");
    }

    List<UserSM> storageModels = [];
    for (UserNM model in networkModels) {
      storageModels.add(mapUserModel(model));
    }

    return storageModels;
  }

  UserSM mapUserModel(UserNM networkModel) {
    return UserSM(
      index: networkModel.index,
      dayOfBirth: networkModel.dayOfBirth,
      email: networkModel.email,
      firstName: networkModel.firstName,
      gender: networkModel.gender,
      lastName: networkModel.lastName,
      phone: networkModel.phone,
      pictureLarge: networkModel.pictureLarge,
      pictureSmall: networkModel.pictureSmall,
    );
  }
}
