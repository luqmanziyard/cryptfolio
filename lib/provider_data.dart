import 'package:flutter/material.dart';

class ProviderData extends ChangeNotifier {
  List<dynamic> dataFromCoinMarketCapApiListingLatest;
  Map<String, dynamic> dataFromCoinMarketCapApiMetaData;
  List<dynamic> dataFromCurrencyConverterApi;
}
