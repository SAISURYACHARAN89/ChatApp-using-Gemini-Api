import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Message {
  final bool isUser;
  final String message;
  final DateTime date;
  Message({required this.isUser, required this.message, required this.date});
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  const Messages({
    Key? key,
    required this.isUser,
    required this.message,
    required this.date,
  }) : super(key: key);

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: message));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 10).copyWith(
        left: isUser ? 100 : 10,
        right: isUser ? 10 : 100,
      ),
      decoration: BoxDecoration(
        
        color: isUser ? Colors.black : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          bottomLeft: isUser ? const Radius.circular(10) : Radius.zero,
          topRight: const Radius.circular(10),
          bottomRight: isUser ? Radius.zero : const Radius.circular(10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isUser)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.account_circle_rounded, color: Colors.white),
            ),
          if (!isUser)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.account_circle),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildStyledText(message, isUser),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 10,
                    color: isUser ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    
                  ),
                ),
              ],
            ),
          ),
          if (!isUser)
            IconButton(
              icon: Icon(Icons.copy),
              onPressed: () => _copyToClipboard(context),
            ),
        ],
      ),
    );
  }

  Widget buildStyledText(String text, bool isUser) {
    List<TextSpan> spans = parseText(text, isUser);

    return RichText(
      text: TextSpan(
        children: spans,
        style: TextStyle(
          fontSize: 16,
          color: isUser ? Colors.white : Colors.black,
        ), // Default style
      ),
    );
  }

  List<TextSpan> parseText(String text, bool isUser) {
    final List<TextSpan> spans = [];
    final RegExp regExp = RegExp(r'\*\*(.*?)\*\*');
    final Iterable<RegExpMatch> matches = regExp.allMatches(text);

    int currentIndex = 0;

    for (final match in matches) {
      if (match.start > currentIndex) {
        spans.add(TextSpan(text: text.substring(currentIndex, match.start)));
      }

      final String matchedText = match.group(1)!;
      spans.add(TextSpan(
        text: matchedText,
        style: TextStyle(
          fontSize: 18, // Larger font size for emphasized text
          fontWeight: FontWeight.bold,
          color: isUser ? Colors.white : Colors.black,
        ),
      ));

      currentIndex = match.end;
    }

    if (currentIndex < text.length) {
      spans.add(TextSpan(text: text.substring(currentIndex)));
    }

    return spans;
  }
}