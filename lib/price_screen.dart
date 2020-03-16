import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/getData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  double value = 0;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> currencyItems = [];
    for (String item in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(item),
        value: item,
      );
      currencyItems.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: currencyItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
          });
        });
  }

  CupertinoPicker iosPicker() {
    List<Widget> pickerItems = [];
    for (String item in currenciesList) {
      pickerItems.add(
        Text(item),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (i) {
        print(i);
      },
      children: pickerItems,
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iosPicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
  }

  Future<void> updateUI() async {
    var data = await getPickerData();
    setState(() {
      value = data[selectedCurrency]['last'];
    });
//    print(value);
  }

  @override
  Widget build(BuildContext context) {
    updateUI();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 48.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 75.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $value $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
    );
  }
}
