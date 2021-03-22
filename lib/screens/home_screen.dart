import 'package:cointickyapp/models/coin_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  // final coinsData0;
  // final coinsData1;
  // final coinsData2;

  final List<dynamic> coinsData;

  const HomeScreen({this.coinsData});

  //const HomeScreen({this.coinsData0, this.coinsData1, this.coinsData2});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String coinBTC;
  String coinETH;
  String coinLTC;

  String selectedCurrency = 'USD';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(
          currency,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() async {
          selectedCurrency = value;

          for (int i = 0; i < cryptoList.length; i++) {
            var data = await Coin()
                .getCryptoCurrentCoinData(cryptoList[i], selectedCurrency);
            updateUI(data, cryptoList[i]);
          }
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  void updateUI(dynamic coinData, String crypto) {
    setState(() {
      if (crypto == cryptoList[0]) {
        if (coinData == null) {
          coinBTC = '?';
          return;
        }
        double tempCoin = coinData['last'];
        coinBTC = tempCoin.toStringAsFixed(2);
      } else if (crypto == cryptoList[1]) {
        if (coinData == null) {
          coinETH = '?';
          return;
        }
        double tempCoin = coinData['last'];
        coinETH = tempCoin.toStringAsFixed(2);
      } else if (crypto == cryptoList[2]) {
        if (coinData == null) {
          coinLTC = '?';
          return;
        }
        double tempCoin = coinData['last'];
        coinLTC = tempCoin.toStringAsFixed(2);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < cryptoList.length; i++) {
      updateUI(widget.coinsData[i], cryptoList[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticky'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildConversions(context, cryptoList[0], coinBTC),
          _buildConversions(context, cryptoList[1], coinETH),
          _buildConversions(context, cryptoList[2], coinLTC),
        ],
      ),
      bottomSheet: Container(
        height: 80.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Center(
          child: Platform.isIOS ? iOSPicker() : androidDropdown(),
        ),
      ),
    );
  }

  Container _buildConversions(
      BuildContext context, String crypto, String coinType) {
    return Container(
      height: 100.0,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            '1 $crypto',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '=',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '$coinType $selectedCurrency',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
