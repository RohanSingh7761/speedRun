import 'package:flutter/material.dart';
import 'package:speed_run/components/auth_text_fields.dart';
import 'package:speed_run/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  void signUserIn() async {
    final authService = AuthService();

    try {
      await authService.signInWithEmail(
        usernameTextController.text,
        passwordTextController.text,
      );
    } catch (e) {
      print("YOUR ERROR -> $e");
    }
  }

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
                hintText: "Username",
              ),

              //* Password text field
              AuthTextField(
                controller: passwordTextController,
                hintText: "Password",
              ),

              //* Sign In button
              GestureDetector(
                onTap: signUserIn,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: const Text("Sign In"),
                ),
              ),

              //* Sign Up option
              GestureDetector(
                onTap: widget.onTap,
                child: const Text("Sign Up Now"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
