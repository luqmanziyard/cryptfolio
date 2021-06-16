import 'package:cryptfolio/constants.dart';
import 'package:cryptfolio/screens/navigatio_screen.dart';
import 'package:cryptfolio/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        backgroundColor: kBlueColor,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kBlackColor,
          ),
          elevation: 0,
          backgroundColor: kBlueColor,
          title: Text(
            'Login',
            style: kTitleTextStyle,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///email
              CustomTextField(
                onChanged: onChangedEmail,
                hintText: 'email',
                error: error,
                height: height,
                width: width,
              ),

              ///password
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
                width: width,
                height: height,
                name: 'log in',
                onTap: onTapLogin,
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

  onTapLogin() async {
    setState(() {
      showSpinner = true;
    });

    if (email == null || password == null) {
      setState(() {
        error = true;
      });
    } else {
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
