import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speed_run/components/auth_text_fields.dart';

class SignUpPage extends StatefulWidget {
  final void Function()? onTap;

  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  // void registerUser() async {
  //   final authService = AuthService();
  //   if (passwordTextController.text == confirmPasswordTextController.text) {
  //     try {
  //       authService.signUpWithEmail(
  //         usernameTextController.text,
  //         passwordTextController.text,
  //       );
  //       Navigator.pop(context);
  //     } on FirebaseAuthException catch (e) {
  //       print("ERROR REGISTERING USER -> $e");
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              //* App Icon
              Icon(Icons.note),

              //* Username text field
              AuthTextField(
                controller: usernameTextController,
                hintText: "Enter Username",
              ),

              //* Password text field
              AuthTextField(
                controller: passwordTextController,
                hintText: "Enter password",
              ),

              //* Confirm Password Text field
              AuthTextField(
                controller: confirmPasswordTextController,
                hintText: "Confirm your password",
              ),

              //* Sign Up button
              GestureDetector(
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: usernameTextController.text,
                      password: passwordTextController.text,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Container(
                  child: const Text("Sign Up"),
                ),
              ),

              //* Sign In option
              GestureDetector(
                onTap: widget.onTap,
                child: const Text("Back to sign In"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
