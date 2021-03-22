import 'package:cointickyapp/models/coin_model.dart';
import 'package:cointickyapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getBTCCoinData();
  }

  void getBTCCoinData() async {
    List<dynamic> coinsData = [];

    for (int i = 0; i < cryptoList.length; i++) {
      var data = await Coin().getCryptoCurrentCoinData(cryptoList[i], 'USD');
      coinsData.add(data);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          coinsData: coinsData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Center(
          child: SpinKitFoldingCube(
            color: Colors.white,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
