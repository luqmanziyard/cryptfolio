import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptfolio/constants.dart';
import 'package:cryptfolio/provider_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final _firestore = FirebaseFirestore.instance;
  String tokenSymbol = 'Token';
  String amount;
  String price;
  double total;
  String status;
  List<String> tokenSymbols = [];
  String uid;
  double lkrValue;
  bool buy = false;
  bool sell = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    uid = FirebaseAuth.instance.currentUser.uid;

    ///getting the lkr value from api
    var url =
        'https://free.currconv.com/api/v7/convert?q=USD_LKR&compact=ultra&apiKey=05770a75f255c5d859ca';
    http.Response response = await http.get(url);

    lkrValue = json.decode(response.body)['USD_LKR'];
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderData>(context)
        .dataFromCoinMarketCapApiListingLatest
        .forEach((element) {
      final symbol = element['symbol'];
      setState(() {
        tokenSymbols.add(symbol);
      });
    });

    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: 540,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: kBlueColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 100,
              ),

              ///title
              Text(
                'Create Order',
                style: TextStyle(
                  color: kBlackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: Container(),
              ),

              ///close button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: Icon(
                    Icons.clear,
                    color: kBlackColor,
                    size: 20,
                  ),
                ),
              )
            ],
          ),

          ///drop down menu
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 5),
            height: 20,
//            width: 120,
            color: Colors.transparent,
            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tokenSymbol,
                  style: kCreateOrderTextFieldTextStyle,
                ),
                Theme(
                  data: ThemeData(
                    canvasColor: kBlackColor,
                  ),
                  child: DropdownButton<String>(
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    items: tokenSymbols.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          width: 50,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (n) {
                      setState(() {
                        tokenSymbol = n;
                      });
                    },
                  ),
                )
              ],
            ),
          ),

          ///amount field
          Container(
            width: 100,
            decoration: kCreateOrderContainerDecor,
            child: TextField(
              keyboardType: TextInputType.number,
              style: kCreateOrderTextFieldTextStyle,
              decoration:
                  kCreateOrderTextFieldStyle.copyWith(hintText: 'Amount'),
              onChanged: (n) {
                setState(() {
                  n == '' ? amount = '0.0' : amount = n;
                });
              },
            ),
          ),

          ///price field
          Container(
            margin: EdgeInsets.only(
              bottom: 0,
            ),
            decoration: kCreateOrderContainerDecor,
            width: 100,
            child: TextField(
              keyboardType: TextInputType.number,
              style: kCreateOrderTextFieldTextStyle,
              decoration:
                  kCreateOrderTextFieldStyle.copyWith(hintText: 'price'),
              onChanged: (n) {
                setState(() {
                  n == '' ? price = '0.0' : price = n;
                });
              },
            ),
          ),

          ///total field
          Container(
            width: 100,
            padding: EdgeInsets.only(
              top: 20,
              bottom: 10,
            ),
            decoration: kCreateOrderContainerDecor,
            child: amount == null || price == null
                ? Text(
                    '0',
                    style: kCreateOrderTextFieldDisabledTextStyle,
                  )
                : Text(
                    (double.parse(amount) * double.parse(price))
                        .toStringAsFixed(2),
                    style: kCreateOrderTextFieldTextStyle,
                  ),
          ),
          SizedBox(
            height: 150,
          ),

          ///buy or sell buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    status = 'buy';
                    sell = false;
                    buy = true;
                  });
                },
                child: Container(
                  height: 30,
                  width: width * 0.4,
                  color: buy ? kGreenColor : kBlueColor,
                  child: Center(
                    child: Text(
                      'Buy',
                      style: TextStyle(
                        color: kLightBlueColor,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    status = 'sell';
                    sell = true;
                    buy = false;
                  });
                },
                child: Container(
                  height: 30,
                  width: width * 0.4,
                  color: sell ? kRedColor : kBlueColor,
                  child: Center(
                    child: Text(
                      'Sell',
                      style: TextStyle(
                        color: kLightBlueColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          ///create order button
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: onPressedCreateOrder,
              child: Container(
                height: 30,
                width: width * 0.8,
                decoration: BoxDecoration(
                  color: kBlueColor,
                  border: Border.symmetric(
                    horizontal: BorderSide(color: kLightBlueColor),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Create Order',
                    style: TextStyle(color: kLightBlueColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onPressedCreateOrder() async {
    final uid = FirebaseAuth.instance.currentUser.uid;

    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat.yMd().format(dateTime);

    if (amount == null ||
        price == null ||
        status == null ||
        tokenSymbol == 'Token') {
      print('amount: $amount');
      print('price: $price');
      print('status: $status');
      print('status: $tokenSymbol');
      print('error');
    } else {
      ///checking if its a sell order and converting the value to negatve
      final double doubleAmount =
          status == 'sell' ? double.parse(amount) * -1 : double.parse(amount);
      final double doublePrice = double.parse(price);

      total = doubleAmount * doublePrice;

      ///adding data of the current purchase
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('portfolio')
          .doc(tokenSymbol)
          .collection('purchase')
          .doc(dateTime.toString())
          .set({
        'date': formattedDate,
        'tokenSymbol': tokenSymbol,
        'amount': doubleAmount,
        'price': doublePrice,
        'total': total,
        'status': status,
        'dateTime': dateTime,
      });

      await _firestore
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .doc(dateTime.toString())
          .set({
        'date': formattedDate,
        'tokenSymbol': tokenSymbol,
        'amount': doubleAmount,
        'price': doublePrice,
        'total': total,
        'status': status,
        'dateTime': dateTime,
      });

      List listOfAmounts = [];
      List lisOfPrices = [];
      double sumOfTokens = 0.0;
      double sumOfPrices = 0.0;

      /// get/calculating the total value of amount of tokens and total invested
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('portfolio')
          .doc(tokenSymbol)
          .collection('purchase')
          .get()
          .then((value) {
        for (var eachValue in value.docs) {
          final amount = eachValue['amount'];
          final price = eachValue['total'];
          listOfAmounts.add(amount);
          lisOfPrices.add(price);
        }
        print(listOfAmounts);
        for (var eachAmount in listOfAmounts) {
          sumOfTokens += eachAmount;
        }
        for (var eachPrice in lisOfPrices) {
          sumOfPrices += eachPrice;
        }
      });

//      sumOfTokens >= 0 ? sumOfTokens = sumOfTokens: sumOfTokens = 0.0;
      sumOfPrices >= 0 ? sumOfPrices = sumOfPrices : sumOfPrices = 0.0001;

      ///adding the total number of tokens and the total invested
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('portfolio')
          .doc(tokenSymbol)
          .set({
        'amountOfTokens': sumOfTokens,
        'amountOfMoney': sumOfPrices,
      });

      double sumOfTokenValuesInUsd = 0.0;

      ///getting values and calculating the networth in usd
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('portfolio')
          .get()
          .then((value) {
        for (var eachValue in value.docs) {
          final double valueOfEachTokenInUsd = eachValue['amountOfMoney'];
          sumOfTokenValuesInUsd += valueOfEachTokenInUsd;
        }
      });

      ///calculating the networth in lrk
      double sumOfTokenValueInLkr = sumOfTokenValuesInUsd * lkrValue;

      ///setting the networth in usd and lkr
      await _firestore.collection('users').doc(uid).update({
        'netWorthInUsd': sumOfTokenValuesInUsd,
        'netWorthInLrk': sumOfTokenValueInLkr,
      });

      Navigator.pop(context);
    }
  }
}
