import 'dart:io' show Platform; // chỉ dùng được nếu không build web
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_windows_app/services/auth_result.dart';

import '../utils/api_client.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<AuthResult> login(String email, String password) async {
    try {
      final res = await ApiClient.post("/auth/login", {"email": email, "password": password});
      return AuthResult(success: true, token: res["token"]);
    } catch (e) {
      return AuthResult(success: false, message: e.toString());
    }
  }

  Future<AuthResult> register(String name, String email, String password, String phone) async {
    try {
      final res = await ApiClient.post("/auth/register", {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      });
      if (res["message"] == "Đăng ký thành công") {
        return AuthResult(success: true, message: res["message"]);
      }
      return AuthResult(success: false, message: res["message"]);
    } catch (e) {
      return AuthResult(success: false, message: e.toString());
    }
  }

  Future<AuthResult> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final cred = await _auth.signInWithPopup(GoogleAuthProvider());
        return AuthResult(success: true, token: await cred.user?.getIdToken());
      } else {
        final googleUser = await _googleSignIn.signIn();
        if (googleUser == null) return AuthResult(success: false, message: "Người dùng hủy đăng nhập");
        final googleAuth = await googleUser.authentication;
        final cred = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final userCred = await _auth.signInWithCredential(cred);
        return AuthResult(success: true, token: await userCred.user?.getIdToken());
      }
    } catch (e) {
      return AuthResult(success: false, message: "Google sign-in error: $e");
    }
  }String? validateEmail(String? value) {
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
  
