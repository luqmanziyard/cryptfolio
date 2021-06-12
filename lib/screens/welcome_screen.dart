import 'package:cryptfolio/constants.dart';
import 'package:cryptfolio/screens/login_screen.dart';
import 'package:cryptfolio/screens/signup_screen.dart';
import 'package:cryptfolio/widgets.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const id = 'welcome screen';
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
              child: Text('cryptfolio'),
            ),
            ActionButton(
              name: 'log in',
              onTap: () => Navigator.pushNamed(context, LoginScreen.id),
            ),
            ActionButton(
              name: 'sign up',
              onTap: () => Navigator.pushNamed(context, SignupScreen.id),
            ),
          ],
        ),
      ),
    );
  }
}
