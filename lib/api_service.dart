import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000/api';

  // Mutluluk verisi için API çağrısı
  static Future<List<dynamic>> getMutlulukData() async {
    final response = await http.get(Uri.parse('$baseUrl/mutluluk_verisi'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Mutluluk Verisi');
    }
  }

  // Güvenlik verisi için API çağrısı
  static Future<List<dynamic>> getGuvenlikData() async {
    final response = await http.get(Uri.parse('$baseUrl/yasanilan_cevrede_guvende_hissetme'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Güvenlik Verisi');
    }
  }
}
