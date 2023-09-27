import 'package:flutter/material.dart';
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/components/my_button.dart';
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/components/my_text_field.dart';
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

// Create a stateful widget called LoginPage
class LoginPage extends StatefulWidget {
  // Declare a variable 'onTap' that will be used for some action when a user taps something
  final void Function()? onTap;

  // Constructor for this widget, takes in 'onTap' as an argument
  const LoginPage({super.key, required this.onTap});

  // Create the state for LoginPage
  @override
  State<LoginPage> createState() => _LoginPageState();
}

// The internal state class for LoginPage
class _LoginPageState extends State<LoginPage> {
  // Create text controllers to manage user inputs
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Function to sign in the user
  void signIn() async {
    // Access the authentication service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      // Try signing in using email and password
      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      // If there's an error, show it as a pop-up at the bottom of the screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  // Describe the part of the UI represented by this widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color of the page
      backgroundColor: Colors.white70,
      body: SafeArea(
        // Make sure the layout is inside safe areas like notch and navigation area
        child: Center(
          // Center the contents
          child: Padding(
            // Add padding around the contents
            padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              // Use a column layout
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Start of the user interface elements
                Image.asset(
                  'assets/chatting.gif',
                  height: 120,
                  width: 120,
                ),
                const Text(
                  "Chatting with friends",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 10),

                // Email input field
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                // Password input field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 20),
                // Sign-in button
                MyButton(onTap: signIn, text: "Sign In"),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // A text and a clickable text for navigation to registration
                    const Text('New user?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }
}
