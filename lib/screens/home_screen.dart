import 'dart:convert';
import 'package:cryptfolio/provider_data.dart';
import 'package:cryptfolio/screens/login_screen.dart';
import 'package:cryptfolio/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> dataFromApiLatestListing =
        Provider.of<ProviderData>(context)
            .dataFromCoinMarketCapApiListingLatest;

    final Map<String, dynamic> dataFromApiMetaData =
        Provider.of<ProviderData>(context).dataFromCoinMarketCapApiMetaData;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pop(context);
          Navigator.pushNamed(context, LoginScreen.id);
        },
        child: Icon(Icons.logout),
      ),
      body: Container(
        child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: dataFromApiLatestListing.length,
            itemBuilder: (BuildContext context, int index) {
              final name = dataFromApiLatestListing[index]['name'].toString();
              final price = dataFromApiLatestListing[index]['quote']['USD']
                      ['price']
                  .toStringAsPrecision(6);
              final symbol = dataFromApiLatestListing[index]['symbol'];
              final percentChange24h = dataFromApiLatestListing[index]['quote']
                  ['USD']['percent_change_24h'];

              final id = dataFromApiLatestListing[index]['id'];

              return TokenCard(
                tokenPrice: price,
                tokenName: name,
                tokenSymbol: symbol,
                percentChange24h: percentChange24h,
              );
            }),
      ),
    );
  }
}

class TokenCard extends StatelessWidget {
  TokenCard(
      {this.tokenName,
      this.percentChange24h,
      this.tokenSymbol,
      this.tokenPrice});
  final String tokenName;
  final String tokenSymbol;
  final double percentChange24h;
  final String tokenPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: 326,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.green,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(tokenName == null ? 'null' : tokenName),
                  Text(tokenSymbol == null ? 'null' : tokenSymbol),
                ],
              ),
              Text('\$${tokenPrice}')
            ],
          ),
          Text(percentChange24h == null
              ? 'null'
              : '${percentChange24h.toStringAsFixed(3)}%')
        ],
      ),
    );
  }
}

class Token {
  final String name, symbol, percentChange24h;

  Token({
    this.name,
    this.symbol,
    this.percentChange24h,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      name: json['name'].toString(),
      symbol: json['symbol'].toString(),
      percentChange24h:
          json['quote']['USD']['forecast']['percent_change_24h'].toString(),
    );
  }
}
