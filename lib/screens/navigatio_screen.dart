import 'dart:convert';
import 'package:cryptfolio/constants.dart';
import 'package:cryptfolio/provider_data.dart';
import 'package:cryptfolio/screens/home_screen.dart';
import 'package:cryptfolio/screens/portfolio_screen.dart';
import 'package:cryptfolio/screens/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class NavigationScreen extends StatefulWidget {
  static const id = 'nav screen';

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  String email;
  String password;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> screens = [
    HomeScreen(),
    TransactionScreen(),
    PortfolioScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveData();
  }

  retrieveData() async {
    ///getting the list of maps from Latest listing url
    var urlLatestListing =
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';
    http.Response responseLatestListing = await http.get(
      urlLatestListing,
      headers: {'X-CMC_PRO_API_KEY': '749b9bac-2b33-44bf-88f9-113786464888'},
    );

    setState(() {
      Provider.of<ProviderData>(context, listen: false)
              .dataFromCoinMarketCapApiListingLatest =
          json.decode(responseLatestListing.body)['data'];
    });

    ///getting the list of maps from Meta Data url
//    var urlMetaData =
//        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/info';
//    http.Response responseMetaData = await http.get(
//      urlMetaData,
//      headers: {'X-CMC_PRO_API_KEY': '749b9bac-2b33-44bf-88f9-113786464888'},
//    );
//
//    Map<String, dynamic> data = jsonDecode(responseMetaData.body);
//    print(data['data']);
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<ProviderData>(context, listen: false)
                .dataFromCoinMarketCapApiListingLatest ==
            null
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: screens[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.compare_arrows),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  label: '',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: kBlueColor,
              unselectedItemColor: kGreyColor,
              onTap: _onItemTapped,
            ),
          );
  }
}
