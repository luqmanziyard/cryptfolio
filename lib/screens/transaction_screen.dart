import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptfolio/screens/create_order_screen.dart';
import 'package:cryptfolio/screens/profile_screen.dart';
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
    return Scaffold(
      backgroundColor: Colors.yellow,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => CreateOrderScreen(),
          );
        },
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
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
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return TransactionCard(
                      data: data,
                      index: index,
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  TransactionCard({
    this.data,
    this.index,
  });

  final List<QueryDocumentSnapshot> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: 100,
      color: Colors.red,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data[index]['date']),
              Text(data[index]['status']),
            ],
          ),
          Text(data[index]['tokenSymbol']),
          Text(data[index]['amount'].toString()),
          Text(data[index]['price'].toString()),
          Text(data[index]['total'].toString()),
        ],
      ),
    );
  }
}
