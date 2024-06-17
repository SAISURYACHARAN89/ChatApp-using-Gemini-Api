import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Message {
  final String message;
  final bool isUser;
  final DateTime timestamp;

  Message({required this.message, required this.isUser, required this.timestamp});

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      isUser: json['isUser'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class ChatController extends GetxController {
  RxList<Message> chatHistory = <Message>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadChatHistory();
  }

  Future<void> loadChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('chatHistory');
    if (jsonString != null) {
      List<dynamic> jsonList = json.decode(jsonString);
      chatHistory.value = jsonList.map((json) => Message.fromJson(json)).toList();
    }
  }

  Future<void> saveMessage(Message message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    chatHistory.add(message);
    String jsonString = json.encode(chatHistory.map((msg) => msg.toJson()).toList());
    await prefs.setString('chatHistory', jsonString);
  }
}

class StartScreen extends StatelessWidget {
  final ChatController _controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat With Gemini'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(ChatScreen());
          },
          child: Text('Go to Chat Screen'),
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final ChatController _controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat History'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _controller.chatHistory.length,
          itemBuilder: (context, index) {
            Message message = _controller.chatHistory[index];
            return ListTile(
              title: Text(message.message),
              subtitle: Text(message.timestamp.toString()),
              leading: CircleAvatar(
                backgroundColor: message.isUser ? Colors.blue : Colors.green,
                child: Icon(message.isUser ? Icons.person : Icons.computer),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Simulate receiving a new message
          Message newMessage = Message(message: 'New Message', isUser: false, timestamp: DateTime.now());
          _controller.saveMessage(newMessage);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    home: StartScreen(),
  ));
}
