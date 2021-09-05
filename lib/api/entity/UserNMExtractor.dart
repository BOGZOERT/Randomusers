import 'dart:convert';

import 'package:http/http.dart';
import 'package:randomusers/api/entity/UserNM.dart';

import 'UserNM.dart';

abstract class UserNMExtractor {
  Future<List<UserNM>> extract(Response response);
}

class UserNMExtractorImpl extends UserNMExtractor {
  @override
  Future<List<UserNM>> extract(Response response) async {
    var jsonData = json.decode(response.body);

    List<UserNM> results = [];
    var index = 0;

    for (var item in jsonData["results"]) {
      var user = UserNM(
        index: index,
        email: item['email'],
        firstName: item['name']['first'],
        lastName: item['name']['last'],
        phone: item['phone'],
        pictureLarge: item['picture']['large'],
        pictureSmall: item['picture']['medium'],
        gender: item['gender'],
      );
      index++;
      results.add(user);
    }

    return results;
  }
}
