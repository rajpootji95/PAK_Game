import 'dart:convert';

import 'package:binance_pay/binance_pay.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pak_games/Model/get_sub_category.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:pak_games/Web%20View%20Screen/web_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api Services/api_end_points.dart';
import '../Model/get_profile_model.dart';
import '../Utils/myWidget.dart';
import '../provider/languageProvider.dart';

class GamesView extends StatefulWidget {
  String? catId;

  GamesView({super.key, this.catId});

  @override
  State<GamesView> createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    getSubCatApi();
    _checkInternetConnection();
  }

  bool _isConnected = true;

  void _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
      });
    } else {
      setState(() {
        _isConnected = true;
      });
    }

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          _isConnected = false;
        });
      } else {
        setState(() {
          _isConnected = true;
        });
      }
    });
  }

  final String clientId =
      "AdylaisGlHD-DdyY3mzuJPxoTpYGXpdwijwTR8tTBjSIPYsOCMW1F3ZzsGZe21sXA6-Bk6xUjWd9iGaK"; // Replace with your sandbox client ID
  //"AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0"; // Replace with your sandbox client ID
  final String secretKey =
      "EI925OdIc6a-sJI_wB_uik251pyZxDj1ijtacwDU9TZHd5JLqTZ6Ybt452vKG9RoheaanGHWiqMCPPdi"; // Replace with your sandbox secret key
  //"EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9"; // Replace with your sandbox secret key
  @override
  Widget build(BuildContext context) {
    return _isConnected
        ? Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: NewText(
                  textFuture: Provider.of<LanguageProvider>(context)
                      .translate('PAK Games'),
                  styles: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black),
                )),
            body: getSubCategoryModel == null
                ? const Center(
                    child: CupertinoActivityIndicator(
                    color: AppColor.primary,
                  ))
                : getSubCategoryModel!.data.isEmpty
                    ? Center(
                        child: NewText(
                        textFuture: Provider.of<LanguageProvider>(context)
                            .translate('No Game Found!!'),
                        styles: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.black),
                      ))
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: NewText(
                                  textFuture:
                                      Provider.of<LanguageProvider>(context)
                                          .translate('Free Games'),
                                  styles: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.black),
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3.0,
                              width: 500,
                              child: GridView.builder(
                                itemCount: getSubCategoryModel?.data
                                    .where((item) => item.type == "0")
                                    .length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 5.0,
                                  childAspectRatio: 1.0,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  var freeGames = getSubCategoryModel?.data
                                      .where((item) => item.type == "0")
                                      .toList();
                                  return freeGames != null
                                      ? Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        WebViewScreen(
                                                      gameUrl:
                                                          freeGames[index].url!,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: SizedBox(
                                                  height: 80,
                                                  width: 80,
                                                  child: Image.network(
                                                    "${freeGames[index].image}",
                                                    fit: BoxFit.fill,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return const Icon(Icons
                                                          .error); // Placeholder for error
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            NewText(
                                              textFuture: Provider.of<
                                                      LanguageProvider>(context)
                                                  .translate(
                                                      "${freeGames[index].title}"),
                                              styles: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.black,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NewText(
                                textFuture:
                                    Provider.of<LanguageProvider>(context)
                                        .translate("Premium Games"),
                                styles: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.black),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3.0,
                              width: 500,
                              child: GridView.builder(
                                itemCount: getSubCategoryModel?.data
                                    .where((item) => item.type == "1")
                                    .length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 5.0,
                                  childAspectRatio: 1.0,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  var paidGames = getSubCategoryModel?.data
                                      .where((item) => item.type == "1")
                                      .toList();
                                  return paidGames != null
                                      ? Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Take  subscription plan'),
                                                    backgroundColor:
                                                        AppColor.primary,
                                                    duration:
                                                        Duration(seconds: 1),
                                                  ),
                                                );
                                                //makePayment();
                                                // Logging to check the credentials
                                                /*  print("Client ID: $clientId");
                                            print("Secret Key: $secretKey");

                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => UsePaypal(

                                                    sandboxMode: true,
                                                    clientId: clientId,
                                                    //"EIrUifCmd-H0738DmFvt0J6E-f4Y1bn5dLK6IjtU_1LawGqFZ2zVjT9_CN1Fw3lglcxCKbmg6wT94Osg",
                                                    secretKey:secretKey,
                                                    //"AQNKaYmo6D5xoAHcYQb7P9bNWqmnhRUh7Ne9XAXLa6ExSVOogXQU0_imte0hjOFZ-JVjy0nDXI3jdWQX",
                                                    returnURL: "https://samplesite.com/return",
                                                    cancelURL: "https://samplesite.com/cancel",
                                                    transactions:  [
                                                      {
                                                        "amount": const {
                                                          "total": '1',
                                                          "currency": "USD",
                                                          "details": {
                                                            "subtotal": '1',
                                                            "shipping": '0',
                                                            "shipping_discount": 0
                                                          }
                                                        },
                                                        "description":
                                                        "The payment transaction description.",
                                                        // "payment_options": {
                                                        //   "allowed_payment_method":
                                                        //       "INSTANT_FUNDING_SOURCE"
                                                        // },
                                                        "item_list": {
                                                          "items": [
                                                            {
                                                              "name": "$userName",
                                                              "quantity": 1,
                                                              "price": '1',
                                                              "currency": "USD"
                                                            }
                                                          ],

                                                          // shipping address is not required though
                                                          "shipping_address": {
                                                            "recipient_name": "$userName",
                                                            "line1": "Travis County",
                                                            "line2": "",
                                                            "city": "Austin",
                                                            "country_code": "US",
                                                            "postal_code": "73301",
                                                            "phone": "+00000000",
                                                            "state": "Texas"
                                                          },
                                                        }
                                                      }
                                                    ],
                                                    note: "Contact us for any questions on your order.",
                                                    onSuccess: (Map params) async {
                                                      getPlanSubscribe();
                                                      print("onSuccess: $params");
                                                    },
                                                    onError: (error) {
                                                      print("onError: $error");
                                                    },
                                                    onCancel: (params) {
                                                      print('cancelled: $params');
                                                    }),
                                              ),
                                            );*/
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: SizedBox(
                                                  height: 80,
                                                  width: 80,
                                                  child: Image.network(
                                                    "${paidGames[index].image}",
                                                    fit: BoxFit.fill,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return const Icon(Icons
                                                          .error); // Placeholder for error
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            NewText(
                                              textFuture: Provider.of<
                                                      LanguageProvider>(context)
                                                  .translate(
                                                      "${paidGames[index].title}"),
                                              styles: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.black,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink();
                                },
                              ),
                            ),
                          ],
                        ),
                      ))
        : Scaffold(
            body: Center(
                child: Image.asset(
            'assets/images/internet.png',
          )));
  }

  String? userId, userName;

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userid");
    getProfileApi();
  }

  GetProfileModel? getProfileModel;

  Future<void> getProfileApi() async {
    var headers = {'Cookie': 'ci_session=jabmg512o22abd8r3bvi86kbgq13ieo5'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Endpoints.baseUrl}get_profile'));
    request.fields.addAll({'user_id': userId.toString()});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetProfileModel.fromJson(json.decode(result));
      getProfileModel = finalResult;
      userName = getProfileModel?.data?.username;
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  getPlanSubscribe() async {
    var headers = {'Cookie': 'ci_session=jdpbq7fm3deavq5q25t24cb20c3rfc6f'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Endpoints.baseUrl}subscribe'));
    request.fields.addAll({'user_id': userId.toString()});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['error'] == false) {}
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  GetSubCategoryModel? getSubCategoryModel;

  getSubCatApi() async {
    var headers = {'Cookie': 'ci_session=rliu6p075fqkj6ogvcrtorav75j548s2'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Endpoints.baseUrl}get_games'));
    request.fields.addAll({'cat_id': widget.catId.toString()});
    print("cat_id${widget.catId}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      getSubCategoryModel = GetSubCategoryModel.fromJson(jsonDecode(result));

      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  makePayment() async {
    BinancePay pay = BinancePay(
      apiKey:
          "oueD0sEAMMNCDfRcjwO0UI30OuRAhw6MBy3dLCTe2Il2dnJyQuNdmnZGaAF9vKA0",
      apiSecretKey:
          "W5ORTL4UyXCjYvqTzYw1Ga95bRu4XR6NOWhZf9bI7aLBX9De4HqPQxJlt6q7d9nJ",
    );

    String tradeNo = generateMerchantTradeNo();

    OrderResponse response;
    try {
      response = await pay.createOrder(
        body: RequestBody(
          merchantTradeNo: tradeNo,
          terminalType: "APP",
          orderAmount: '1.01',
          currency: 'USDT',
          goodsType: '01',
          goodsCategory: '1000',
          referenceGoodsId: 'referenceGoodsId',
          goodsName: 'goodsName',
          goodsDetail: 'goodsDetail',
        ),
      );
      // Log the entire response for debugging
      //debugPrint("CreateOrder response: ${response.toJson()}");
    } catch (e) {
      debugPrint("Order creation failed: $e");
      return;
    }
    debugPrint("Order response: ${response.errorMessage}");
    if (response.data == null) {
      debugPrint("Failed to create order. No data returned.");
      return;
    }

    /// Query the order
    QueryResponse queryResponse;
    try {
      queryResponse = await pay.queryOrder(
        merchantTradeNo: tradeNo,
        prepayId: response.data?.prepayId ?? "1",
      );
      // Log the entire response for debugging
      //debugPrint("QueryOrder response: ${queryResponse.toJson()}");
    } catch (e) {
      debugPrint("Order query failed: $e");
      return;
    }
    CloseResponse closeResponse;
    try {
      closeResponse = await pay.closeOrder(
        merchantTradeNo: tradeNo,
      );

      // Log the entire response for debugging
      //debugPrint("CloseOrder response: ${closeResponse.toJson()}");
    } catch (e) {
      debugPrint("Order closing failed: $e");
      return;
    }
    debugPrint(closeResponse.status);
  }

// String generateMerchantTradeNo() {
//   // Generate a unique trade number (implement as per your requirement)
//   return DateTime.now().millisecondsSinceEpoch.toString();
// }
}
