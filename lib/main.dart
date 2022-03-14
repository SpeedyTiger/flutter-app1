// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter_app/views/login_page.dart';
import 'package:firebase_flutter_app/views/sign_up_page.dart';
import 'package:firebase_flutter_app/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
// Replace with actual values
    options: FirebaseOptions(
      apiKey: "AIzaSyArjgFR159FZpCf7NJfY8m4ETKXvmjgw7E",
      appId: "1:770417837957:android:9c5409fceec6edbf17a6ec",
      messagingSenderId: "770417837957",
      projectId: "uniticsoft",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
