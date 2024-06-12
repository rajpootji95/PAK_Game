import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:pak_games/Api%20Services/api_end_points.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:provider/provider.dart';

import '../Model/get_privacy_policy_model.dart';
import '../Model/get_term_condtion_model.dart';
import '../Utils/myWidget.dart';
import '../provider/languageProvider.dart';


class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrivacyPolicyApi();
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
  @override
  Widget build(BuildContext context) {
    return _isConnected ? Scaffold(

      appBar: AppBar(
      iconTheme: const IconThemeData(
      color: AppColor.white, //change your color here
      ),
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title:  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Privacy Policy'),styles: const TextStyle(
            color: AppColor.white,fontSize: 20,fontWeight: FontWeight.w500,fontFamily: 'Lora'
        ) ,),

      ),
      body:getTmc?.data == null ? const Center(child: CupertinoActivityIndicator()):getTmc?.data?.description== null ? const Center(child: Text("No Terms & Condition"))  :Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: ListView(
          children: [
            NewText(textFuture: Provider.of<LanguageProvider>(context).translate('${getTmc?.data?.description}'),styles: const TextStyle(

            ) ,),

          ],
        ),
      ),
    ):Scaffold(body: Center(child: Image.asset('assets/images/internet.png',)));
  }

  GetPrivacyPolicyModel? getTmc;
  getPrivacyPolicyApi() async {
    var headers = {
      'Cookie': 'ci_session=14mb2r2eqlv8afkg4s2oesvk0mlbhl77'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Endpoints.baseUrl}privacy_policy'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     var result = await response.stream.bytesToString();
      var finalResult = GetPrivacyPolicyModel.fromJson(jsonDecode(result));
      setState(() {
        getTmc = finalResult;
      });
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
