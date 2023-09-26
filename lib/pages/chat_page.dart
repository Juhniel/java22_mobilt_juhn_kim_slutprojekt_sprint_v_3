// Import necessary packages
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore database
import 'package:firebase_auth/firebase_auth.dart'; // Firebase authentication
import 'package:flutter/material.dart'; // Basic Flutter widgets
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/components/my_text_field.dart'; // Custom text field
import 'package:java22_mobilt_juhn_kim_slutprojekt_sprint_v_3/services/chat/chat_service.dart'; // Chat service

// Create a stateful widget called ChatPage
class ChatPage extends StatefulWidget {
  // Declare variables for the receiver's email and user ID
  final String receiverUserEmail;
  final String receiverUserId;

  // Constructor to initialize variables
  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserId,
  });

  // Create the state for ChatPage
  @override
  State<ChatPage> createState() => _ChatPageState();
}

// Internal state class for ChatPage
class _ChatPageState extends State<ChatPage> {
  // Text controller for message input
  final TextEditingController _messageController = TextEditingController();

  // Chat service to handle chat functionalities
  final ChatService _chatService = ChatService();

  // Firebase authentication instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Function to send a message
  void sendMessage() async {
    // Check if the message input is not empty
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, _messageController.text
      );
      // Clear the text field after sending the message
      _messageController.clear();
    }
  }

  // Describe the UI elements in this widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.receiverUserEmail)), // Top App Bar
        body: Column(
          children: [
            // Build the message list
            Expanded(
              child: _buildMessageList(),
            ),
            // Input field for new messages
            _buildMessageInput(),
          ],
        ));
  }

  // Build the message list from Firestore database
  Widget _buildMessageList() {
    return StreamBuilder(
      // Fetch messages from Firestore
      stream: _chatService.getMessages(
          widget.receiverUserId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        // Show error if any
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }

        // Show loading text if data is still loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        // Create a list of message items
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // Build each individual message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Decide message alignment based on the sender
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    // Create message item UI
    return Container(
        alignment: alignment,
        child: Column(
          children: [
            Text(data['senderEmail']), // Sender's email
            Text(data['message']),     // Actual message
          ],
        ));
  }

  // Build the message input section
  Widget _buildMessageInput() {
    return Row(
      children: [
        // Text field to input new message
        Expanded(
          child: MyTextField(
            controller: _messageController,
            hintText: 'Enter message',
            obscureText: false,
          ),
        ),
        // Button to send the message
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.arrow_upward,
            size: 40,
          ),
        ),
      ],
    );
  }
}
