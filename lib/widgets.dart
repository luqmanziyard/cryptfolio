import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptfolio/constants.dart';
import 'package:cryptfolio/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class ActiveButton extends StatelessWidget {
  ActiveButton({this.name, this.onTap, this.height, this.width});
  final String name;
  final Function onTap;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.075,
        width: width * 0.8,
        child: Center(
            child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: kLightBlueColor,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}

class InActiveButton extends StatelessWidget {
  InActiveButton({this.name, this.onTap});
  final String name;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 300,
        child: Center(
            child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.transparent,
          border: Border.all(
            width: 3,
            color: kLightBlueColor,
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.onChanged,
      this.hintText,
      this.errorText,
      this.error,
      this.obscureText = false,
      this.width,
      this.height});
  final Function onChanged;
  final String hintText;
  final String errorText;
  final bool error;
  final bool obscureText;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1,
      width: width * 0.8,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        obscureText: obscureText,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          errorText: errorText,
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w200,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: error ? kRedColor : kGreyColor),
            borderRadius: BorderRadius.circular(25),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: error ? kRedColor : kGreyColor),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: error ? kRedColor : kGreyColor),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  ProfileButton({this.width, this.height});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ProfileScreen.id),
      child: Container(
        height: height * 0.075,
        width: width * 0.106,
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
  TokenCard({
    this.tokenName,
    this.percentChange24h,
    this.tokenSymbol,
    this.tokenPrice,
    this.width,
    this.height,
  });
  final String tokenName;
  final String tokenSymbol;
  final double percentChange24h;
  final String tokenPrice;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.12,
      width: width * 0.85,
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

class TransactionCard extends StatelessWidget {
  TransactionCard({
    this.data,
    this.index,
    this.height,
    this.width,
  });

  final List<QueryDocumentSnapshot> data;
  final int index;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * .229,
      width: width * 0.869,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: kLightBlueColor, borderRadius: BorderRadius.circular(20)),
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
