import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speed_run/pages/home_page.dart';
import 'package:speed_run/pages/login_or_register.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While checking the auth state, show a loading spinner
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            // If authenticated, show the home page
            return HomePage();
          } else {
            // If not authenticated, show the login/register page
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
