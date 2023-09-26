// Import the necessary Flutter package and pages
import 'package:flutter/material.dart';
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/pages/login_page.dart';
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/pages/register_page.dart';

// Define a stateful widget named LoginOrRegister
class LoginOrRegister extends StatefulWidget {
  // Constructor to initialize the LoginOrRegister widget
  const LoginOrRegister({super.key});

  // Create the mutable state object for this widget
  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

// Define the mutable state object
class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Define a boolean variable to decide which page to show (Login or Register)
  bool showLoginPage = true;

  // Function to toggle between Login and Register pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  // Build the widget tree for this state
  @override
  Widget build(BuildContext context) {
    // Decide which page to show based on the boolean variable
    if(showLoginPage) {
      // If showLoginPage is true, show LoginPage and pass the toggle function
      return LoginPage(onTap: togglePages);
    } else {
      // Otherwise, show RegisterPage and pass the toggle function
      return RegisterPage(onTap: togglePages);
    }
  }
}
