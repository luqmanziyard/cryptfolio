import 'package:cryptfolio/screens/navigatio_screen.dart';
import 'package:cryptfolio/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  static const id = 'loading screen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String uid;

  @override
  void initState() {
    super.initState();
    assignUser();
  }

  assignUser() async {
    try {
      uid = FirebaseAuth.instance.currentUser.uid;
      print("success");
    } catch (e) {
      print("its a null");
      uid = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return uid == null ? WelcomeScreen() : NavigationScreen();
  }
}
