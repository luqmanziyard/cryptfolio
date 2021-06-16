import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptfolio/constants.dart';
import 'package:cryptfolio/provider_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  double netWorthInLkr = 0;
  double netWorthInUsd = 0;

  Map<String, double> randomMap = {};

  List<Color> randomColors = [];

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
      if (mounted) {
        setState(() {
          netWorthInUsd = value['netWorthInUsd'];
          netWorthInLkr = value['netWorthInLrk'];
        });
      }
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('portfolio')
        .orderBy('amountOfMoney', descending: true)
        .get()
        .then((tokens) {
      for (var eachToken in tokens.docs) {
        final String tokenName = eachToken.id;
        final double amountOfMoney = eachToken['amountOfMoney'];
        if (mounted) {
          setState(() {
            Random random = Random();
            final color = Color((random.nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0);

            randomColors.add(color);
            randomMap[tokenName] = amountOfMoney;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final uid = FirebaseAuth.instance.currentUser.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Portfolio',
          style: kTitleTextStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: randomColors.isEmpty || randomMap.isEmpty
            ? Center(
                child: Text(
                  'Please add a transaction to \nshow your net worth',
                  textAlign: TextAlign.center,
                ),
              )
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: PieChart(
                      dataMap: randomMap,
                      animationDuration: Duration(milliseconds: 800),
                      chartRadius: MediaQuery.of(context).size.width / 4,
                      colorList: randomColors,
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 20,
                      centerText: "",
                      legendOptions: LegendOptions(
                        showLegends: false,
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValueBackground: false,
                        showChartValues: false,
                        showChartValuesInPercentage: true,
                        showChartValuesOutside: false,
                        decimalPlaces: 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${netWorthInUsd.toStringAsFixed(2)} USD',
                          style: kTokenCardTokenNameStyle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${netWorthInLkr.toStringAsFixed(2)} LKR',
                          style: kTokenCardTokenNameStyle.copyWith(
                              color: Colors.black),
                        ),
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
                          padding: EdgeInsets.symmetric(horizontal: 20),
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

                            final currentValue = double.parse(amountOfTokens) *
                                currentValueOfToken;
                            final currentProfit = currentValue - amountInvested;

                            return PortfolioCard(
                              amountOfTokens: amountOfTokens,
                              currentProfit: currentProfit,
                              tokenName: tokenName,
                              currentValue: currentValue,
                              index: index,
                              colorList: randomColors,
                              width: width,
                              height: height,
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

class PortfolioCard extends StatelessWidget {
  const PortfolioCard({
    Key key,
    @required this.amountOfTokens,
    @required this.currentProfit,
    @required this.tokenName,
    @required this.currentValue,
    this.colorList,
    this.index,
    this.height,
    this.width,
  });

  final String amountOfTokens;
  final double currentProfit;
  final String tokenName;
  final double currentValue;
  final List<Color> colorList;
  final int index;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.869,
      height: height * 0.119,
      margin: EdgeInsets.only(
        bottom: 15,
      ),
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
        ///logo
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
        ),

        ///tokenName
        title: Row(
          children: [
            Text(
              tokenName,
              style: kPortfolioCardTokenSymbolStyle,
            ),
            SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: 5,
              backgroundColor: colorList[index],
            ),
          ],
        ),

        ///price of token
        subtitle: Text(
          '\$${currentValue.toStringAsFixed(2)}',
          style: kPortfolioCardTokenPriceStyle,
        ),

        ///amount and gains
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              amountOfTokens,
              style: kPortfolioCardAmountStyle,
            ),
            Text(
              currentProfit >= 0
                  ? '+${currentProfit.toStringAsFixed(2)}'
                  : currentProfit.toStringAsFixed(2),
              style: TextStyle(
                color: currentProfit >= 0 ? kGreenColor : kRedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
