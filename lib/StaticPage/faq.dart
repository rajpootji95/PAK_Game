import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pak_games/Api%20Services/api_end_points.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:provider/provider.dart';

import '../Model/get_faq_model.dart';
import '../Utils/myWidget.dart';
import '../provider/languageProvider.dart';

class FeqScreen extends StatefulWidget {
  const FeqScreen({super.key});

  @override
  State<FeqScreen> createState() => _FeqScreenState();
}

class _FeqScreenState extends State<FeqScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFeqApi();
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
        title:   NewText(textFuture: Provider.of<LanguageProvider>(context).translate('FAQ'),styles: const TextStyle(
        color: AppColor.white
        ) ,),

      ),
      body: getFaq?.data == null ? const Center(child: CupertinoActivityIndicator(color: AppColor.primary,)):getFaq!.data.isEmpty  ? const Center(child: Text("No Faq Found!!")) :Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: ListView.builder(
              itemCount: getFaq?.data.length,
              itemBuilder: (context, i) {
                return Card(
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title:  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('${getFaq?.data[i].question}'),styles: const TextStyle(
                          fontWeight: FontWeight.w700
                      ) ,),

                      children: [
                        ListTile(
                          subtitle:  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('${getFaq?.data[i].answer}'),styles: const TextStyle(
                          fontWeight: FontWeight.w300
                          ) ,),

                        )
                      ],
                    ),
                  ),
                );


              })),
    );
  }

  GetFaqModel? getFaq;

  getFeqApi() async {
    var headers = {'Cookie': 'ci_session=14mb2r2eqlv8afkg4s2oesvk0mlbhl77'};
    var request =
        http.MultipartRequest('POST', Uri.parse('${Endpoints.baseUrl}faq'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetFaqModel.fromJson(jsonDecode(result));
      setState(() {
        getFaq = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
}
