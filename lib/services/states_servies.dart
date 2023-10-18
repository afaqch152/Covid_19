import 'dart:convert';

import 'package:covid_19/model/world_state_model.dart';
import 'package:covid_19/services/utilites/appUrls.dart';
import 'package:http/http.dart';

class StateServices {
  Future<WorldStatesModel> fetchWorldStatesApi() async {
    final response = await get(Uri.parse(ApiUrl.worldStateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> fetchCountriesStatesApi() async {
    var data;
    final response = await get(Uri.parse(ApiUrl.countriesApi));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
