import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;
  final String apiKey;

  NetworkHelper(
    this.url,
    this.apiKey,
  );

  Future getData() async {
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {'x-ba-key': apiKey},
    );

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
