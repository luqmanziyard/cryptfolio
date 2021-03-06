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

const InputDecoration kCreateOrderTextFieldDecor = InputDecoration(
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

const TextStyle kPortfolioCardTokenSymbolStyle = TextStyle(color: Colors.white);

const TextStyle kPortfolioCardTokenPriceStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const TextStyle kPortfolioCardAmountStyle = TextStyle(
  color: Colors.white,
);

List<Color> colorList = [
  Colors.red,
  Colors.green,
  Colors.yellow,
  Colors.pink,
  Colors.purple,
];

const TextStyle kProfileTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
);

const TextStyle kProfileFieldTitleStyle = TextStyle(
  color: kGreyColor,
  fontSize: 18,
);

const BoxDecoration kLogOutButtonDecor = BoxDecoration(
  color: kBlueColor,
  border: Border.symmetric(
    horizontal: BorderSide(color: kLightBlueColor),
  ),
);

const TextStyle kLogoutStyle = TextStyle(color: kLightBlueColor);

const InputDecoration kAuthTextFieldDecor = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 20),
  hintText: 'email',
  hintStyle: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w200,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
  ),
);
