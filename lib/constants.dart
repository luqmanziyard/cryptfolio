import 'package:flutter/material.dart';

const Color kBlueColor = Color(0xff4772B9);
const Color kYellowColor = Color(0xffF4CA89);
const Color kLightBlueColor = Color(0xff86CAE8);
const Color kWhiteColor = Color(0xffffffff);
const Color kBlackColor = Color(0xff0C182C);
const Color kGreyColor = Color(0xffB0B7BD);
const Color kGreenColor = Color(0xff58FF87);
const Color kRedColor = Color(0xffF86B6B);

const TextStyle kTitleTextStyle = TextStyle(color: kBlackColor);
const TextStyle kTokenCardTokenNameStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const TextStyle kTokenCardTokenSymbolStyle = TextStyle(color: Colors.white);

const TextStyle kTokenCardTokenPriceStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);
const TextStyle kTransactionCardBuyStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: kGreenColor,
);
const TextStyle kTransactionCardSellStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: kRedColor,
);
const TextStyle kTransactionCardSubtitleStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

const TextStyle kTransactionCardTokenSymbolStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const TextStyle kTransactionCardDateStyle = TextStyle(
  color: Colors.white,
);

const InputDecoration kCreateOrderTextFieldStyle = InputDecoration(
  contentPadding: EdgeInsets.all(0),
  hintText: 'price',
  hintStyle: kCreateOrderTextFieldDisabledTextStyle,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  ),
);

const BoxDecoration kCreateOrderContainerDecor = BoxDecoration(
  border: Border(
    bottom: BorderSide(
      width: 3,
      color: Colors.white,
    ),
  ),
);

const TextStyle kCreateOrderTextFieldTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
);

const TextStyle kCreateOrderTextFieldDisabledTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 18,
);
