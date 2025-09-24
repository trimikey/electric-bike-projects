import 'package:flutter/material.dart';
import 'package:test_windows_app/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool rememberMe = false;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(blurRadius: 10, color: Colors.black12),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const Icon(Icons.electric_car, size: 80, color: Colors.blue),
                Image.asset(
                  'lib/assets/Logo_xe_dien_EV.png',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Đăng nhập",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                // asd
                // Email
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Mật khẩu",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),

                // Remember + Forgot
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        StatefulBuilder(
                          builder: (context, setState) {
                            return Checkbox(
                              value: rememberMe,
                              onChanged: (val) {
                                setState(() => rememberMe = val ?? false);
                              },
                            );
                          },
                        ),
                        const Text("Nhớ mật khẩu"),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/forgot-password");
                      },
                      child: const Text("Quên mật khẩu?"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Login button
                ElevatedButton(
                  onPressed: () {
                    // TODO: gọi API login
                    Navigator.pushReplacementNamed(context, "/home");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("Đăng nhập"),
                ),
                const SizedBox(height: 16),

                // Register link
                Column(
                  children: [
                    const Text("Bạn chưa có tài khoản?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: const Text("Đăng ký tài khoản"),
                    ),
                  ],
                ),



                const SizedBox(height: 16),

                OutlinedButton.icon(
                  icon: Image.asset(
                    'lib/assets/Google_logo.svg',
                    width: 24,
                    height: 24,
                  ),
                  label: const Text(
                    "Đăng nhập với Google",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey), // viền xám
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 20,
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                  ),
                  
                  onPressed: () async {
                    final authService = AuthService();
                    final user = await authService.signInWithGoogle();
                    if (user != null) {
                      Navigator.pushReplacementNamed(context, "/home");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Đăng nhập Google thất bại"),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
