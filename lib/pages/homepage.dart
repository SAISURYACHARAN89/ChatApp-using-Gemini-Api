import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:geminichatai/pages/message.dart/message.dart';
import 'package:geminichatai/pages/startscreen.dart';
import 'package:geminichatai/utils/constants/sizes.dart';
import 'package:geminichatai/utils/helpers/helper_functions.dart';
import 'package:geminichatai/wid/chatarea.dart';
import 'package:geminichatai/wid/hometextformfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _userinput = TextEditingController();
  static const apikey = "AIzaSyCwigrYSHoNS2Lya5qlsi9TKGl9V2I5sCw";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apikey);
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();

  Future<void> sendMessage() async {
    final message = _userinput.text;
    setState(() {
      _messages.add(Message(isUser: true, message: message, date: DateTime.now()));
    });
    _userinput.clear();
    _scrollToEnd(); // Scroll to the end after sending a message

    final content = [Content.text(message)];

    try {
      final response = await model.generateContent(content);
      print("Response from model: ${response.text}");

      if (response.text != null) {
        setState(() {
          _messages.add(Message(isUser: false, message: response.text!, date: DateTime.now()));
        });
        _scrollToEnd(); // Scroll to the end after adding the response
      } else {
        print("Model response text is null.");
      }
    } catch (e, stacktrace) {
      print("Error generating content: $e");
      print("Stacktrace: $stacktrace");
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.to(StartScreen()),
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.pinkAccent,
        title: const Text('Chat With Gemini'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splashx.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Messages(
                    isUser: message.isUser,
                    message: message.message,
                    date: DateFormat('HH:mm').format(message.date),
                  );
                },
              ),
            ),
            SizedBox(height: TSizes.spaceBtwSections),
            HomeTextFormField(controller: _userinput, onPressed: sendMessage),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
