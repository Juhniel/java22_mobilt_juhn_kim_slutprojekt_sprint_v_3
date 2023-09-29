// Import the necessary Flutter package and pages
import 'package:flutter/material.dart';
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/pages/login_page.dart';
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {

  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Define a boolean variable to decide which page to show (Login or Register)
  bool showLoginPage = true;

  // Function to toggle between Login and Register pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Decide which page to show based on the boolean variable
    if(showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
