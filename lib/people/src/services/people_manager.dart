import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

abstract class PeoPleManager {

  static Future<String> getJSONData() async {

    var url = Uri.https("swapi.dev", "/api/people");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      for (var item in jsonResponse['results']) {}

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return "Dados obtidos com sucesso";
  }


}
