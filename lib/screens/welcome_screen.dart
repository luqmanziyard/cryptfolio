import 'package:cryptfolio/constants.dart';
import 'package:cryptfolio/screens/login_screen.dart';
import 'package:cryptfolio/screens/signup_screen.dart';
import 'package:cryptfolio/widgets.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const id = 'welcome screen';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kBlueColor,
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cryptfolio',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Organize your satoshis',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ActiveButton(
                height: height,
                width: width,
                name: 'log in',
                onTap: () => Navigator.pushNamed(context, LoginScreen.id),
              ),
              InActiveButton(
                name: 'sign up',
                onTap: () => Navigator.pushNamed(context, SignupScreen.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
