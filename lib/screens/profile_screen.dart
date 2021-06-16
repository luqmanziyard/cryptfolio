import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptfolio/constants.dart';
import 'package:cryptfolio/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  static const id = 'profile screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email;
  String dateJoined;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    email = FirebaseAuth.instance.currentUser.email;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      final Timestamp timestamp = value['dateTime'];

      var date =
          DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
      setState(() {
        dateJoined = DateFormat.yMMMd().format(date);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: kBlackColor,
        ),
        title: Text(
          'Profile',
          style: kTitleTextStyle,
        ),
      ),
      backgroundColor: kBlueColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              child: Icon(Icons.person_outline),
            ),

            ///email
            ListTile(
              title: Text(
                'Email',
                style: kProfileFieldTitleStyle,
              ),
              subtitle: Text(
                email,
                style: kProfileTitleStyle,
              ),
            ),

            ///date joined
            ListTile(
              title: Text(
                'Date joined',
                style: kProfileFieldTitleStyle,
              ),
              subtitle: Text(
                dateJoined == null ? 'loading' : dateJoined,
                style: kProfileTitleStyle,
              ),
            ),
            Expanded(child: Container()),

            ///log out button
            TextButton(
              onPressed: louOutUser,
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                height: height * 0.059,
                decoration: kLogOutButtonDecor,
                child: Center(
                  child: Text(
                    'Log Out',
                    style: kLogoutStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  louOutUser() {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(context, WelcomeScreen.id);
  }
}
