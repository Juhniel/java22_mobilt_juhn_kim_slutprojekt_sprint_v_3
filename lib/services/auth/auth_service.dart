import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// Create a class called AuthService that notifies its listeners of changes.
class AuthService extends ChangeNotifier {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance of firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Method to sign in a user with email and password
    Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
      try {
        // Try to sign in with user
        UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
        );

        // Add a new document for this user in the Firestore 'users' collection
        // or merge it if it already exists
        // Kanske ta bort?
        _fireStore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
        }, SetOptions(merge: true));

        // Return the signed-in user's credentials
        return userCredential;
      }
      // Catch any error
      on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
    }

  // Method to sign up a new user with email and password
  Future<UserCredential> signUpWithEmailAndPassword(String email, password) async {
      try{
        UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
                email: email,
                password: password,
            );

        // After creating the user, add a new document for this user in the Firestore 'users' collection
        _fireStore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
        });
        // Return the new user's credentials
        return userCredential;
      } on FirebaseAuthException catch (e) {
        // Catch and throw any errors
        throw Exception(e.code);
      }
  }

  // Method to sign out a user
  Future<void> signOut() async {
      return await FirebaseAuth.instance.signOut();
  }
}