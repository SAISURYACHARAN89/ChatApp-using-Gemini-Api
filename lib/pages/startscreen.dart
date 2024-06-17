import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geminichatai/pages/homepage.dart';
import 'package:geminichatai/utils/constants/sizes.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.webp'), // Replace 'assets/background_image.jpg' with your image asset path
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.electric_bolt_outlined),
            backgroundColor: Colors.pinkAccent, // Make app bar transparent
            elevation: 0, // Remove app bar elevation
            title: const Text('Chat With Gemini', style: TextStyle(color: Colors.white)), // Set app bar title color
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent, // Make scaffold background transparent
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Container(
                padding: EdgeInsets.all(20), // Add padding for the highlighted area
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6), // Semi-transparent black color
                  borderRadius: BorderRadius.circular(20), // Rounded corners for the highlighted area
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('ChatBot Using Gemini', style: TextStyle(fontSize: TSizes.lg, color: Colors.white)),
                    SizedBox(height: TSizes.spaceBtwItems,),
                    Text('Built by Sai Surya Charan P', style: TextStyle(fontSize: TSizes.md, color: Colors.white)),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () => Get.to(() => HomePage()),
                      child: Text('Go to Chat with AI', style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.w300)),
                    ),
                       
                  
                       
                  ],

                ),
                
              ),
            ),
          
          ),
        ),
      ],
    );
  }
}
