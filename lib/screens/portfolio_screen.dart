import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptfolio/provider_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  double netWorthInLkr = 0;
  double netWorthInUsd = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      setState(() {
        netWorthInUsd = value['netWorthInUsd'];
        netWorthInLkr = value['netWorthInLrk'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(netWorthInUsd.toStringAsFixed(2)),
                  Text(netWorthInLkr.toStringAsFixed(2)),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .collection('portfolio')
                    .orderBy('amountOfMoney', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final data = snapshot.data.docs;
                  final dataFromApi = Provider.of<ProviderData>(context)
                      .dataFromCoinMarketCapApiListingLatest;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final tokenName = data[index].id;
                      final amountOfTokens =
                          data[index]['amountOfTokens'].toString();
                      final amountInvested = data[index]['amountOfMoney'];

                      double currentValueOfToken;
                      for (var eachMap in dataFromApi) {
                        if (eachMap['symbol'] == tokenName) {
                          currentValueOfToken =
                              eachMap['quote']['USD']['price'];
                        }
                      }

                      final currentValue =
                          double.parse(amountOfTokens) * currentValueOfToken;
                      final currentProfit = currentValue - amountInvested;

                      return Card(
                        color: Colors.red,
                        child: ListTile(
                          focusColor: Colors.red,
                          leading: Text(tokenName),
                          trailing: Text(amountOfTokens),
                          title: Text(
                            currentValue.toStringAsFixed(2),
                          ),
                          subtitle: Text(currentProfit.toStringAsFixed(4)),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
