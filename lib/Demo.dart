// //
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'dart:math';
// //
// // import 'package:flutter/widgets.dart';
// //
// // class Demo extends StatefulWidget {
// //   const Demo({super.key});
// //
// //   @override
// //   State<Demo> createState() => _DemoState();
// // }
// //
// // class _DemoState extends State<Demo> {
// //  int selectedNumberRight = Random().nextInt(6) + 1;
// //  int selectedNumberLeft = Random().nextInt(6) + 1;
// //  void generateNumberRight(){
// //    setState(() {
// //      selectedNumberRight = Random().nextInt(6) + 1;
// //
// //    });
// //  }
// //  void generateNumberLeft(){
// //    setState(() {
// //      selectedNumberLeft = Random().nextInt(6) + 1;
// //
// //    });
// //  }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         title:  const Text("Dice"),),
// //        body: Center(
// //          child: Padding(
// //            padding:  const EdgeInsets.all(8.0),
// //            child: Row(
// //              children: [
// //                Expanded(
// //                  child: InkWell(
// //                      onTap: (){
// //                        generateNumberLeft();
// //                      },
// //                      child: Image.asset("assets/images/Dice/dice$selectedNumberLeft.png",scale: 2.3,)),
// //                ),
// //                const SizedBox(width: 10,),
// //                Expanded(
// //                  child: InkWell(
// //                      onTap: (){
// //                        generateNumberRight();
// //                      },
// //                      child: Image.asset("assets/images/Dice/dice$selectedNumberRight.png",scale: 2.3,)),
// //                ),
// //              ],
// //            )
// //          ),
// //        )
// //     );
// //   }
// // }
//
// import 'dart:convert';
//
// import 'package:binance_pay/binance_pay.dart';
// import 'package:http/http.dart' as http;
//
//
// class BinancePay {
//   final String apiKey;
//   final String apiSecretKey;
//
//   BinancePay({required this.apiKey, required this.apiSecretKey});
//
//   Future<OrderResponse> createOrder({required RequestBody body}) async {
//     // Generate nonce string
//     final nonce = generateNonceString();
//
//     // Construct request body
//     final requestBody = {
//       "env": {
//         "terminalType": body.terminalType,
//       },
//       "merchantTradeNo": body.merchantTradeNo,
//       "orderAmount": body.orderAmount,
//       "currency": body.currency,
//       "description": body.description,
//       "goodsDetails": body.goodsList.map((element) => element.toMap()).toList(),
//     };
//
//     final jsonRequest = json.encode(requestBody);
//     final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
//     final payload = "$timestamp\n$nonce\n$jsonRequest\n";
//     final signature = generateSignature(payload, apiSecretKey).toUpperCase();
//
//     // v3
//     final url = "https://bpay.binanceapi.com/binancepay/openapi/v3/order";
//
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       "BinancePay-Timestamp": timestamp,
//       "BinancePay-Nonce": nonce,
//       "BinancePay-Certificate-SN": apiKey,
//       "BinancePay-Signature": signature
//     };
//
//     http.Response response = await http.post(
//       Uri.parse(url),
//       headers: headers,
//       body: jsonRequest,
//     );
//
//     final responseBody = jsonDecode(response.body);
//
//     return OrderResponse.fromJson(responseBody);
//   }
//
//   Future<QueryResponse> queryOrder({
//     /// The unique Binance Pay order ID.
//     ///
//     /// This property holds the order ID assigned by Binance Pay after a successful
//     /// request. It might be `null` if the request is still pending, failed, or canceled.
//     String? prepayId,
//
//     /// A unique identifier for the merchant's order (optional).
//     ///
//     /// This property allows you to assign a unique ID to your order within your
//     /// application. However, it is ignored by Binance Pay if a `prepayId` is
//     /// already provided.
//     ///
//     /// Use `merchantTradeNo` to track orders on your end and potentially correlate
//     /// them with the `prepayId` received from Binance Pay.
//     String? merchantTradeNo,
//   }) async {
//     if (prepayId == null && merchantTradeNo == null) {
//      // throw MissingRequestException('prepayId or merchantTradeNo is required');
//     }
//
//     // Generate nonce string
//     final nonce = generateNonceString();
//
//     // Construct request body
//     final requestBody = {};
//     if (prepayId != null) {
//       requestBody['prepayId'] = prepayId;
//     } else {
//       requestBody['merchantTradeNo'] = merchantTradeNo;
//     }
//
//     final jsonRequest = json.encode(requestBody);
//     final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
//     final payload = "$timestamp\n$nonce\n$jsonRequest\n";
//     final signature = generateSignature(payload, apiSecretKey).toUpperCase();
//
//     const url = "https://bpay.binanceapi.com/binancepay/openapi/v2/order/query";
//
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       "BinancePay-Timestamp": timestamp,
//       "BinancePay-Nonce": nonce,
//       "BinancePay-Certificate-SN": apiKey,
//       "BinancePay-Signature": signature
//     };
//
//     http.Response response = await http.post(
//       Uri.parse(url),
//       headers: headers,
//       body: jsonRequest,
//     );
//
//     final responseBody = jsonDecode(response.body);
//
//     return QueryResponse.fromJson(responseBody);
//   }
//
//   Future<CloseResponse> closeOrder({
//     /// The unique Binance Pay order ID.
//     ///
//     /// This property holds the order ID assigned by Binance Pay after a successful
//     /// request. It might be `null` if the request is still pending, failed, or canceled.
//     String? prepayId,
//
//     /// A unique identifier for the merchant's order (optional).
//     ///
//     /// This property allows you to assign a unique ID to your order within your
//     /// application. However, it is ignored by Binance Pay if a `prepayId` is
//     /// already provided.
//     ///
//     /// Use `merchantTradeNo` to track orders on your end and potentially correlate
//     /// them with the `prepayId` received from Binance Pay.
//     String? merchantTradeNo,
//   }) async {
//     if (prepayId == null && merchantTradeNo == null) {
//      // throw MissingRequestException('prepayId or merchantTradeNo is required');
//     }
//
//     // Generate nonce string
//     final String nonce = generateNonceString();
//
//     // Construct request body
//     final requestBody = {};
//     if (prepayId != null) {
//       requestBody['prepayId'] = prepayId;
//     } else {
//       requestBody['merchantTradeNo'] = merchantTradeNo;
//     }
//
//     final String jsonRequest = json.encode(requestBody);
//     final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
//
//     final String payload = "$timestamp\n$nonce\n$jsonRequest\n";
//
//     final String signature =
//     generateSignature(payload, apiSecretKey).toUpperCase();
//
//     const url = "https://bpay.binanceapi.com/binancepay/openapi/order/close";
//
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       "BinancePay-Timestamp": timestamp,
//       "BinancePay-Nonce": nonce,
//       "BinancePay-Certificate-SN": apiKey,
//       "BinancePay-Signature": signature
//     };
//
//     http.Response response = await http.post(
//       Uri.parse(url),
//       headers: headers,
//       body: jsonRequest,
//     );
//
//     final responseBody = jsonDecode(response.body);
//
//     return CloseResponse.fromJson(responseBody);
//   }
// }
