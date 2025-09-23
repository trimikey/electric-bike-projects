import '../utils/api_client.dart';

class AuthService {
  // gọi API login
  Future<String?> login(String email, String password) async {
    try {
      final res = await ApiClient.post("/auth/login", {
        "email": email,
        "password": password,
      });

      // giả sử backend trả về { "access_token": "..." }
      return res["token"];
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }
  Future<bool> register(String name, String email, String password, String phone) async {
    try {
      final res = await ApiClient.post("/auth/register", {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      });

      // giả sử backend trả về { "success": true }
      return res["success"] ?? false;
    } catch (e) {
      print("Register error: $e");
      return false;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Vui lòng nhập email";
    if (!value.contains("@")) return "Email không hợp lệ";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Vui lòng nhập mật khẩu";
    if (value.length < 6) return "Mật khẩu ít nhất 6 ký tự";
    return null;
  }
}
