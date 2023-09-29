import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/services/auth/logged_in_page.dart';
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/services/auth/login_or_register.dart';

class AuthenticationGate extends StatelessWidget {

  const AuthenticationGate({super.key});

  // Describe the UI elements in this widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use the whole screen for this widget
        body: StreamBuilder(
          // Listen to authentication state changes
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // if user is logged in or not
              if(snapshot.hasData) {
                return const LoggedInPage(); // Show the home page
              } else {
                return const LoginOrRegister(); // Show the login or register page
              }
            }
        )
    );
  }
}
