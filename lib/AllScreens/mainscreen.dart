import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget
{
  const MainScreen({Key? key}) : super(key: key);
  //Registration and Login page link
  static const String idScreen="mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("This is Main Screen"),
      ),
    );
  }
}
