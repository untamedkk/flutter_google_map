import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:map_example/model/poeple_list.dart';
import 'package:map_example/people_list/api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider;

  ApiRepository(this._apiProvider);

  Future<Peoples> getPeopleList() async {
    try {
      var response = await _apiProvider.getPeopleList();
      return Peoples.fromJson(json.decode(response));
    } catch (err) {
      debugPrint('Unable to fetch the list. $err');
      return null;
    }
  }
}
