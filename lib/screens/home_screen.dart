import 'package:cryptfolio/constants.dart';
import 'package:cryptfolio/provider_data.dart';
import 'package:cryptfolio/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final List<dynamic> dataFromApiLatestListing =
        Provider.of<ProviderData>(context)
            .dataFromCoinMarketCapApiListingLatest;

    final Map<String, dynamic> dataFromApiMetaData =
        Provider.of<ProviderData>(context).dataFromCoinMarketCapApiMetaData;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          actions: [
            ProfileButton(
              height: height,
              width: width,
            ),
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
                height: height,
                width: width,
              );
            }),
      ),
    );
  }
}
