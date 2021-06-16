import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptfolio/constants.dart';
import 'package:cryptfolio/screens/create_order_screen.dart';
import 'package:cryptfolio/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
  }

  getUid() {
    uid = FirebaseAuth.instance.currentUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Transactions',
          style: kTitleTextStyle,
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
          color: kBlueColor,
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => CreateOrderScreen(),
          );
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('transactions')
            .orderBy('dateTime', descending: true)
            .limitToLast(10)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            final data = snapshot.data.docs;
            if (data.isEmpty) {
              return Center(
                child: Text(
                  'Press the plus button to add \na transaction',
                  textAlign: TextAlign.center,
                  style: kTitleTextStyle,
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return TransactionCard(
                  data: data,
                  index: index,
                  width: width,
                  height: height,
                );
              },
            );
          }
        },
      ),
    );
  }
}
