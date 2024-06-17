import 'package:flutter/material.dart';

class chatArea1 extends StatelessWidget {
  const chatArea1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500, // Example height
      color: Colors.red, // Example color to visualize the container
      child: const Center(
        child: Text(
          'This container fills the max width',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
