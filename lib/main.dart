import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laba4/cripto_coins_repository/cripto_repository.dart';
import 'package:laba4/crypto_coin.dart';

void main() async {
  _list = await CriptoCoinsRepository().getCoinsList();
  runApp(const MyApp());
}
late List<CryptoCoins> _list;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: _list == null ? SizedBox() :
          ListView.builder(
            itemCount: _list!.length,
            itemBuilder: (context, index) {
              final coin = _list![index];
              final coinName = coin.name;
              final coinPrice = coin.priceInUSD;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Image.network(coin.imageURL),
                  title: Text(coinName),
                  subtitle: Text(coinPrice.toString()),
                  tileColor: Colors.white,
                ),
              );
            },
          ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        _list = await CriptoCoinsRepository().getCoinsList();
        setState(() {});
      }, child: Icon(Icons.arrow_circle_down),),
    );
  }
}
