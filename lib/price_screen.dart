import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'models/coin_model.dart';
import 'services/remote_services.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  DropdownButton<String> getDropdownButton() {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: currenciesList.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
    );
  }

  CupertinoPicker getIOSPicker() {
    return CupertinoPicker(
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32,
      onSelectedItemChanged: (int selectedItem) {
        setState(() {
          selectedCurrency = currenciesList[selectedItem];
	  //selectedCoin = cryptoList[indexx];
	  print(selectedCoin);
          getData(selectedCurrency, cryptoList.first);
        });
      },
      children: List<Widget>.generate(currenciesList.length, (int index) {
        return Center(
          child: Text(
            currenciesList[index],
          ),
        );
      }),
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return getIOSPicker();
    } else if (Platform.isAndroid) {
      return getDropdownButton();
    }
  }

  CoinData coinData;
  var isLoaded = false;
  @override
  void initState() {
    super.initState();
    getData(currenciesList.first, cryptoList.first);

  }

  getData(String selectedCurrenci, String selectedCoinn) async {
    coinData = await RemoteService(currency: selectedCurrenci, coin: selectedCoinn).fetchCoinData();
    if (coinData != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  String selectedCurrency;
  
  String dropdownValue = currenciesList.first;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Visibility(
        visible: isLoaded,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomCard(
			    coin: cryptoList.first,
              text: '1 BTC =${coinData.rate.toInt()}  ${coinData.assetIdQuote}',
            ),
CustomCard(
		coin: cryptoList[1],
              text: '1 ETH =${coinData.rate.toInt()}  ${coinData.assetIdQuote}',
            ),
CustomCard(
		coin: cryptoList[2],
              text: '1 LTC =${coinData.rate.toInt()}  ${coinData.assetIdQuote}',
            ),

            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getPicker(),
            ),
          ],
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
