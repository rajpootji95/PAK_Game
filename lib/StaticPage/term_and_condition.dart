import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:pak_games/Api%20Services/api_end_points.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:provider/provider.dart';

import '../Model/get_term_condtion_model.dart';
import '../Utils/myWidget.dart';
import '../provider/languageProvider.dart';


class TermAndCondition extends StatefulWidget {
  const TermAndCondition({super.key});

  @override
  State<TermAndCondition> createState() => _TermAndConditionState();
}

class _TermAndConditionState extends State<TermAndCondition> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTermAndConditionApi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColor.white, //change your color here
        ),
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title:
        NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Terms & Condition'),styles: const TextStyle(
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
    );
  }

  GetTermAndConditionModel? getTmc;
  getTermAndConditionApi() async {
    var headers = {
      'Cookie': 'ci_session=14mb2r2eqlv8afkg4s2oesvk0mlbhl77'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Endpoints.baseUrl}terms_and_conditions'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     var result = await response.stream.bytesToString();
      var finalResult = GetTermAndConditionModel.fromJson(jsonDecode(result));
      setState(() {
        getTmc = finalResult;
      });
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
