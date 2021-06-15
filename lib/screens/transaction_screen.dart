import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptfolio/constants.dart';
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
            return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: kLightBlueColor, borderRadius: BorderRadius.circular(20)),
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data[index]['tokenSymbol'],
                    style: kTransactionCardTokenSymbolStyle,
                  ),
                  Text(
                    data[index]['status'],
                    style: data[index]['status'] == 'buy'
                        ? kTransactionCardBuyStyle
                        : kTransactionCardSellStyle,
                  ),
                ],
              ),
              Text(
                data[index]['date'].toString(),
                style: kTransactionCardDateStyle,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: kTransactionCardSubtitleStyle,
              ),
              Text(
                data[index]['amount'].toString(),
                style: kTransactionCardSubtitleStyle,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price', style: kTransactionCardSubtitleStyle),
              Text(
                data[index]['price'].toStringAsFixed(2),
                style: kTransactionCardSubtitleStyle,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: kTransactionCardSubtitleStyle,
              ),
              Text(
                data[index]['total'].toStringAsFixed(2),
                style: kTransactionCardSubtitleStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
