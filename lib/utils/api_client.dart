import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = "http://localhost:5000"; // Android Emulator
  // Nếu chạy Web/Desktop thì đổi thành "http://localhost:5000" "http://10.0.2.2:5000"

  static Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$path");
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Lỗi: ${response.body}");
    }
  }
}
