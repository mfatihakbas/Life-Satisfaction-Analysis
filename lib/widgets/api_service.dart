import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<List<dynamic>> getMutlulukData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/mutluluk_verisi'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Veri alınamadı');
    }
  }

  static Future<List<dynamic>> getGuvenlikData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/yasanilan_cevrede_guvende_hissetme'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Veri alınamadı');
    }
  }

  static Future<List<dynamic>> getKazancData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/kazanctan_memnuniyet'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Veri alınamadı');
    }
  }

  static Future<List<dynamic>> getRefahData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/refah_seviyesi'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Veri alınamadı');
    }
  }


}
