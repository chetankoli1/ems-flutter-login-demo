import 'package:example/screens/homeScreen.dart';
import 'package:example/screens/loginScreen.dart';
import 'package:example/screens/registrationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: const FirebaseOptions(
    //     apiKey: 'AIzaSyCOMJ2EEz_D2NC91doQKVliFLHhhGgr6ck',
    //     appId: '1:848423069883:android:c1d53306a427da2f37219e',
    //     messagingSenderId: '848423069883',
    //     projectId: 'flutter-demo-28d6a',
    //     storageBucket: 'flutter-demo-28d6a.appspot.com'),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      routes: {
        'login': (context) => const LoginScreen(),
        'register': (context) => const RegistrationScreen(),
        'home': (context) => const HomeScreen()
      },
    );
  }
}
