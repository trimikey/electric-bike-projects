class AuthResult {
  final bool success;     // Cho biết thao tác thành công hay thất bại
  final String? token;    // JWT token (nếu có), để lưu cho phiên đăng nhập
  final String? message;  // Thông báo lỗi/thành công từ backend
  AuthResult({required this.success, this.token, this.message});
}
