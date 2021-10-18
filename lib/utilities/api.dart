import 'dart:convert';

import 'package:http/http.dart' as http;

const String apikey = '898A4F13-6C22-48B9-8D8D-230DE095A72D';

class ApiService {
  Future<List> getPost() async {
    try {
      String url =
          'https://rest.coinapi.io/v1/assets/?apikey=$apikey';

      var response = await http.get(Uri.parse(url));
      // ignore: avoid_print
      print(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      return Future.error('error');
    }
  }
}
