import 'dart:convert';
import 'package:cryptfolio/constants.dart';
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
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        actions: [
          ProfileButton(),
        ],
        title: Text(
          'Home',
          style: kTitleTextStyle,
        ),
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
    );
  }
}

class ProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ProfileScreen.id),
      child: Container(
        height: 40,
        width: 40,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Icon(
          Icons.person_outline,
          size: 20,
          color: Colors.grey,
        ),
        decoration: BoxDecoration(
          color: kBlackColor,
          borderRadius: BorderRadius.circular(5),
        ),
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
      height: 80,
//      width: 320,
      margin: EdgeInsets.only(bottom: 20),

      decoration: BoxDecoration(
        color: kLightBlueColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 5,
            offset: Offset(
              0,
              2,
            ), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.green,
        ),
        title: Row(
          children: [
            Text(
              tokenName == null ? 'null' : tokenName,
              style: kTokenCardTokenNameStyle,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              tokenSymbol == null ? 'null' : tokenSymbol,
              style: kTokenCardTokenSymbolStyle,
            )
          ],
        ),
        subtitle: Text(
          '\$$tokenPrice',
          style: kTokenCardTokenPriceStyle,
        ),
        trailing: Text(
          percentChange24h == null
              ? 'null'
              : '${percentChange24h.toStringAsFixed(2)}%',
          style: TextStyle(
            color: percentChange24h >= 0 ? kGreenColor : kRedColor,
          ),
        ),
      ),
    );
  }
}
