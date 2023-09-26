// Import necessary packages
import 'package:firebase_auth/firebase_auth.dart'; // For Firebase authentication
import 'package:flutter/material.dart'; // Basic Flutter widgets
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/services/auth/home_page.dart'; // Home page widget
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/services/auth/login_or_register.dart'; // Login or Register widget

// Create a stateless widget called AuthGate
class AuthGate extends StatelessWidget {
  // Constructor to initialize the widget
  const AuthGate({super.key});

  // Describe the UI elements in this widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use the whole screen for this widget
        body: StreamBuilder(
          // Listen to authentication state changes
            stream: FirebaseAuth.instance.authStateChanges(),
            // Build the UI based on the authentication state
            builder: (context, snapshot) {
              // If the user is logged in
              if(snapshot.hasData) {
                return const HomePage(); // Show the home page
              } else {
                // If the user is not logged in
                return const LoginOrRegister(); // Show the login or register page
              }
            }
        )
    );
  }
}
