import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../crypto_coin.dart';

class CriptoCoinsRepository {
  Future<List<CryptoCoins>> getCoinsList() async {
    final response = await Dio().get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ADA,ETH,BNB,AVAX,LTC,BCH,XLM,DOGE,USDT&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;

    final dataList = dataRaw.entries.map((e) {
      final usdData = (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final price = usdData['PRICE'];
      final image = usdData['IMAGEURL'];

      return CryptoCoins(
        name: e.key,
        priceInUSD: price,
        imageURL:'https://www.cryptocompare.com/' + image,
    );}).toList();
    return dataList;
  }
}