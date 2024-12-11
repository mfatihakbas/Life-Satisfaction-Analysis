import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String apiUrl = 'http://10.0.2.2:5000/api/mutluluk_verisi';

  static Future<List<dynamic>> getData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }
}
