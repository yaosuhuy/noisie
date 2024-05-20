import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:noisie/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return SafeArea(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter YouTube UI',
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          brightness: Brightness.dark,
          // bottomNavigationBarTheme:
        ),
        home: const SplashScreen(),
        // home: const PlayerScreen(),
      ),
    );
  }
}
 // This trailing comma makes auto-formatting nicer for build methods.
    
  

