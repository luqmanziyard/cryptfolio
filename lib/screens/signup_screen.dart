import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptfolio/constants.dart';
import 'package:cryptfolio/screens/navigatio_screen.dart';
import 'package:cryptfolio/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const id = 'sign up screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
              name: 'sign up',
              onTap: onTapSignUp,
            ),
          ],
        ),
      ),
    );
  }

  onTapSignUp() async {
    DateTime dateTime = DateTime.now();
    try {
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = FirebaseAuth.instance.currentUser.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'netWorthInUsd': 0,
        'netWorthInLrk': 0,
        'dateTime': dateTime,
      });
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
