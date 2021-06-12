import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptfolio/constants.dart';
import 'package:cryptfolio/screens/navigatio_screen.dart';
import 'package:cryptfolio/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                decoration: InputDecoration(hintText: 'email'),
                onChanged: (n) {
                  email = n;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: TextFormField(
                decoration: InputDecoration(hintText: 'password'),
                onChanged: (n) {
                  password = n;
                },
              ),
            ),
            ActionButton(
              name: 'log in',
              onTap: onTapLogin,
            ),
          ],
        ),
      ),
    );
  }

  onTapLogin() async {
    try {
      ///gets the user
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final uid = FirebaseAuth.instance.currentUser.uid;
      print(uid);

      ///check if there is a user != null
      if (user != null) {
        Navigator.pushNamed(context, NavigationScreen.id);
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    }
  }
}
