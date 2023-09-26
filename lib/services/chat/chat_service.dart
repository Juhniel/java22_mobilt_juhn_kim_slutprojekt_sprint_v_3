import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/model/message.dart';

// Create a class ChatService which extends ChangeNotifier to allow UI update notifications
class ChatService extends ChangeNotifier {
  // Initialize instances of FirebaseAuth and FirebaseFirestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Method to send a message
  Future<void> sendMessage(String receiverId, String message) async {
    // Fetch current user ID and email from Firebase Auth
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();

    // Create a new timestamp
    final Timestamp timestamp = Timestamp.now();

    // Create a new message object
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    // Generate a unique chat room ID using the sender and receiver IDs
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // Sorting ensures the chat room ID is always the same for the same pair of users
    String chatRoomId = ids.join("_"); // Create chatRoomId by joining the two sorted ids

    // Add the new message to Firestore
    await _fireStore.collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // Method to retrieve messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // Generate a unique chat room ID using the user and the other user's IDs
    List<String> ids = [userId, otherUserId];
    ids.sort(); // Sorting ensures the chat room ID is always the same for the same pair of users
    String chatRoomId = ids.join("_");

    // Fetch and return the message snapshots ordered by timestamp
    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
