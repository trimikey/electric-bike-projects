import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_windows_app/pages/forget_screen.dart';
import 'package:test_windows_app/pages/login_screen.dart';
import 'package:test_windows_app/pages/register_screen.dart';
import 'package:test_windows_app/pages/home_screen.dart';
import 'firebase_options.dart'; // import file cấu hình Firebase


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // 👈 truyền options
  );  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "EV Dealer Management",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
      routes: {
        "/register": (context) => const RegisterScreen(),
        "/forgot-password": (context) => const ForgotPasswordScreen(),

        "/home": (context) => const HomeScreen(), 
      },
    );
  }
}
