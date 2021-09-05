import 'package:http/http.dart' as http;
import 'package:randomusers/api/entity/UserNM.dart';
import 'package:randomusers/api/entity/UserNMExtractor.dart';

abstract class RandomUserApi {
  Future<List<UserNM>> getUsersList();
}

class RandomUserApiImpl extends RandomUserApi {
  @override
  Future<List<UserNM>> getUsersList() async {
    var response = await http.get(Uri.parse(_userListUrl));
    return await UserNMExtractorImpl().extract(response);
  }

  String _userListUrl = "https://randomuser.me/api/?results=20";
}
