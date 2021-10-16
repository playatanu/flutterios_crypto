import 'dart:convert';

import 'package:http/http.dart' as http;

const String api = '898A4F13-6C22-48B9-8D8D-230DE095A72D';

class ApiService {
  Future<List> getPost(_chosenValue) async {
    try {
      String url =
          'https://rest.coinapi.io/v1/exchangerate/BTC/$_chosenValue?apikey=$api';
      var response = await http.get(Uri.parse(url));
      print(response.body);
      return jsonDecode(response.body);
      print(response.body);
    } catch (e) {
      return Future.error('error');
    }
  }
}
