import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptfolio/constants.dart';
import 'package:cryptfolio/screens/navigatio_screen.dart';
import 'package:cryptfolio/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupScreen extends StatefulWidget {
  static const id = 'sign up screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email;
  String password;

  bool error = false;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kBlackColor,
          ),
          elevation: 0,
          backgroundColor: kBlueColor,
          title: Text(
            'Sing up',
            style: kTitleTextStyle,
          ),
        ),
        backgroundColor: kBlueColor,
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                onChanged: onChangedEmail,
                hintText: 'email',
                error: error,
                height: height,
                width: width,
              ),
              CustomTextField(
                onChanged: onChangedPassword,
                hintText: 'password',
                error: error,
                obscureText: true,
                height: height,
                width: width,
              ),
              SizedBox(
                height: height * 0.045,
              ),
              ActiveButton(
                name: 'Sign up',
                onTap: onTapSignUp,
                height: height,
                width: width,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onChangedEmail(n) {
    email = n;
    setState(() {
      error = false;
    });
  }

  onChangedPassword(n) {
    password = n;
    setState(() {
      error = false;
    });
  }

  onTapSignUp() async {
    setState(() {
      showSpinner = true;
    });
    DateTime dateTime = DateTime.now();
    if (email == null || password == null) {
      setState(() {
        error = true;
      });
    } else {
      try {
        final user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        if (user != null) {
          final uid = FirebaseAuth.instance.currentUser.uid;
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'uid': uid,
            'email': email,
            'netWorthInUsd': 0.0,
            'netWorthInLrk': 0.0,
            'dateTime': dateTime,
          });
          Navigator.pushNamed(context, NavigationScreen.id);
        } else {
          print('error');
        }
      } catch (e) {
        setState(() {
          error = true;
        });
      }
    }

    setState(() {
      showSpinner = false;
    });
  }
}
