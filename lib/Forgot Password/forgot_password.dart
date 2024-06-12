import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pak_games/Api%20Services/api_end_points.dart';
import 'package:pak_games/Auth/verify_otp_screen.dart';
import 'package:provider/provider.dart';

import '../Utils/colors.dart';
import '../Utils/myWidget.dart';
import '../provider/languageProvider.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  String? countryCode,mobileNumber;
  @override
  String? mobile = "Enter Mobile Number";
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context).translate('Enter Mobile Number').then((value){
      mobile = value;
    });

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColor.white, //change your color here
        ),
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title:
        NewText(textFuture: Provider.of<LanguageProvider>(context).translate('forgot Password'),styles: const TextStyle(
            color: AppColor.white,fontSize: 20,fontWeight: FontWeight.w500,fontFamily: 'Lora'
        ) ,),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InternationalPhoneNumberInput(
                maxLength: 12,
                onInputChanged: (PhoneNumber number) {
                    countryCode = number.dialCode;
                   mobileNumber = number.phoneNumber;
                },
                onInputValidated: (bool value) {
                  if (kDebugMode) {
                    print(value ? 'Valid' : 'Invalid');
                  }
                },
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  useEmoji: false,
                  leadingPadding: 20,

                  trailingSpace: false,
                ),
                ignoreBlank: true,
                initialValue: number,
                textFieldController: mobileController,
                formatInput: true,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                inputDecoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Adjusted padding
                  hintText: mobile,
                  hintStyle: const TextStyle(fontSize: 14.0), // Smaller font size
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColor.pinkDark),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColor.pinkDark),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColor.pinkDark),
                  ),
                ),

                spaceBetweenSelectorAndTextField: 0,
                onSaved: (PhoneNumber number) {
                  mobileNumber = number.phoneNumber;
                },
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
                onTap: () {
                  if (mobileController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content:
                      Text('Please enter mobile number'),backgroundColor: AppColor.primary,duration: Duration(seconds: 1),
                      ),
                    );
                  } else if (mobileController.text.length < 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter 10 digit number'),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
                    );

                  } else {
                    loginWithMobileNumberApi();
                  }
                },
                child:  Padding(
                  padding: const EdgeInsets.only(left: 0,top: 0,bottom: 0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width/1.1,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor.pinkDark),
                    child:
                     Center(child: isLoading ? const Center(child: CircularProgressIndicator(color: AppColor.white,)):  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Send OTP'),styles: const TextStyle(
                           color: AppColor.white,fontSize: 20,fontWeight: FontWeight.w500,fontFamily: 'Lora'
                           ) ,),)
                  ),
                )
            ),
          ],
        ),
      ),



    );
  }


  String? mobileNo;
  int? mobileOtp;

  Future<void> loginWithMobileNumberApi() async {
    setState(() {
      isLoading =  true;
    });

    var headers = {
      'Cookie': 'ci_session=5nbd4rujnmj58327kb67h560njukte8i'
    };
    var request = http.MultipartRequest('POST', Uri.parse("${Endpoints.baseUrl}resend_otp"));
    request.fields.addAll({
      'mobile':mobileController.text.replaceAll("-", "").replaceAll(" ", ""),
      'country_code':countryCode!

    });
    debugPrint("this ius nis is ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if(finalResult['error'] == true){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${finalResult['message']}"),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
        );
      }else{
        mobileOtp = finalResult['data']['otp'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${finalResult['message']}"),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
        );

        Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyScreen(forgotMobile: mobileNumber,otp:mobileOtp,countryCode:countryCode,isForget: true,mobile:mobileController.text ))).then((value){
          mobileController.clear();
        });

      }
      setState(() {
        isLoading =  false;
      });
    }
    else {
      setState(() {
        isLoading =  false;
      });
      print(response.reasonPhrase);
    }

  }
  String initialCountry = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
}
