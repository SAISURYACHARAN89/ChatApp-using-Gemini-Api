import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:geminichatai/pages/homepage.dart';
import 'package:geminichatai/pages/startscreen.dart';
import 'package:geminichatai/utils/constants/text_strings.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // initialBinding: GeneralBindings(),
      home: const Scaffold(
        body: Center(
          child: StartScreen()
        ),
      ),
    );
  }
}
