import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_notes_app/screens/home/home_page.dart';
import 'package:online_notes_app/screens/user_onboarding/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        
      ),
      home:Login_Page()
    );
  }
}

