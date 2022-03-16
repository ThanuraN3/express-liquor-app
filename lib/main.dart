import 'package:express/AllScreens/loginScreen.dart';
import 'package:express/AllScreens/mainscreen.dart';
import 'package:express/AllScreens/registrationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

DatabaseReference userRef=FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Express Liquor App',
      theme: ThemeData(
        fontFamily: "Brand Bold",
        primarySwatch: Colors.blue,),
      // home: RegistrationScreen(),
      initialRoute: LoginScreen.idScreen,
      routes:
      {
        RegistrationScreen.idScreen:(context)=>RegistrationScreen(),
        LoginScreen.idScreen:(context)=>LoginScreen(),
        MainScreen.idScreen:(context)=>MainScreen(),
      },
      debugShowCheckedModeBanner: false ,
    );
  }
}
