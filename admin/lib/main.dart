import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:admin/authentication/login_screen.dart';
import 'package:admin/main_screens/home_screen.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAYBFkgk6t2eYOfbrH3J_mC37ufLAmQKXI",
          authDomain: "stellar-11eb2.firebaseapp.com",
          databaseURL: "https://stellar-11eb2-default-rtdb.asia-southeast1.firebasedatabase.app",
          projectId: "stellar-11eb2",
          storageBucket: "stellar-11eb2.appspot.com",
          messagingSenderId: "370255198036",
          appId: "1:370255198036:web:5e8959f414f7fbfcc43ac1"
      )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Web Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? const LoginScreen() : const HomeScreen(),
    );
  }
}


