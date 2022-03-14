import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_app/views/login_page.dart';
import 'package:firebase_flutter_app/views/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {

  static AuthController instance = Get.find();
  
  late Rx<User?> _user;
  TextEditingController emailController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _startScreen);
  }

  _startScreen(User? user) {
    if (user == null) {
      print("login page");
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => WelcomePage(email: user.email ?? "Not found",));
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About User", "User Message",
          backgroundColor: Colors.lightBlueAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Account creation failed",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          )
      );
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About User", "User Message",
          backgroundColor: Colors.lightBlueAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "login failed",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          )
      );
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
            Get.snackbar(
              "Success",
               "Check your inbox for email (also check spam/junk)",
               snackPosition: SnackPosition.BOTTOM,
               backgroundColor: Colors.green,
              );
    } catch (e) {
      // print(e); // showError(title: '...', error: e);
      Get.snackbar("About User", "User Message",
          backgroundColor: Colors.lightBlueAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Reset Failed...",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          )
      );
    }
  }

  void logOut() async{
    await auth.signOut();
  }

  void googleSignUp() async{
    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

    if (googleAccount != null) {
      GoogleSignInAuthentication signInAuthentication = await googleAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken
      );

      await  auth.signInWithCredential(credential);
    }
  }
}