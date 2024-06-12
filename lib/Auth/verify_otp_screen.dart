import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pak_games/Auth/login.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api Services/api_end_points.dart';
import '../Home Screen/homeScreen.dart';
import '../Utils/myWidget.dart';
import '../provider/languageProvider.dart';

class VerifyScreen extends StatefulWidget {
  String? mobile, name, email, password, countryCode, forgotMobile;
  int? otp, forgotOtp;
  bool? isTrue;
  bool? isForget;

  VerifyScreen(
      {super.key,
      this.mobile,
      this.otp,
      this.name,
      this.email,
      this.password,
      this.isTrue,
      this.countryCode,
      this.isForget,
      this.forgotOtp,
      this.forgotMobile});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool isLoading = false;
  String? newPin;
  bool _newPasswordVisible = false;

  final _newPassC = TextEditingController();
  String newPass = "Enter  Password";

  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context)
        .translate('Enter Password')
        .then((value) {
      newPass = value;
    });
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Center(
                          child: Icon(
                        Icons.arrow_back,
                        color: AppColor.black,
                      )),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Center(
                        child: NewText(
                          textFuture: Provider.of<LanguageProvider>(context)
                              .translate('Verification'),
                          styles: const TextStyle(
                              color: AppColor.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lora'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 14,
            child: Container(
              decoration: const BoxDecoration(
                  // color: backGround,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(50))),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 50),
                    child: Column(
                      children: [
                        NewText(
                          textFuture: Provider.of<LanguageProvider>(context)
                              .translate('Code has sent to'),
                          styles: const TextStyle(
                            color: AppColor.black,
                          ),
                        ),

                        widget.isForget == true
                            ? Text(
                                widget.forgotMobile.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "${widget.countryCode}${widget.mobile.toString()}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),

                        Text(
                          "OTP: ${widget.otp.toString()}",
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        PinCodeTextField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            widget.otp = int.parse(value);
                            newPin = value.toString();
                          },
                          textStyle: const TextStyle(color: Colors.black),
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            activeColor: AppColor.pinkLight,
                            inactiveColor: AppColor.pinkLight,
                            selectedColor: AppColor.pinkLight,
                            fieldHeight: 60,
                            fieldWidth: 60,
                            selectedFillColor: AppColor.pinkLight,
                            inactiveFillColor: AppColor.pinkLight,
                            activeFillColor: AppColor.pinkLight,
                          ),
                          //pinBoxRadius:20,
                          appContext: context,
                          length: 4,
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        widget.isForget == true
                            ? TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _newPassC,
                                obscureText: !_newPasswordVisible,
                                //This will obscure text dynamically
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: newPass,
                                  hintStyle: const TextStyle(fontSize: 15),
                                  prefixIcon: Icon(Icons.lock_outlined,
                                      size: 20, color: AppColor.pinkLight),
                                  contentPadding: const EdgeInsets.only(top: 5),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _newPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColor.pinkLight,
                                      size: 18,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _newPasswordVisible =
                                            !_newPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            NewText(
                              textFuture: Provider.of<LanguageProvider>(context)
                                  .translate(
                                      "Haven't received the verification code?"),
                              styles: const TextStyle(
                                  color: AppColor.black, fontSize: 16),
                            ),
                            InkWell(
                              onTap: () {
                                resendOtpApi();
                              },
                              child: NewText(
                                textFuture:
                                    Provider.of<LanguageProvider>(context)
                                        .translate("Resend"),
                                styles: const TextStyle(
                                    color: AppColor.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 50,
                        ),
                        // Obx(() => Padding(padding: const EdgeInsets.only(left: 25, right: 25), child: controller.isLoading.value ? const Center(child: CircularProgressIndicator(),) :
                        //
                        // )

                        widget.isForget == true
                            ? InkWell(
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    if (newPin == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Please enter pin'),
                                            backgroundColor: AppColor.primary,
                                            duration: Duration(seconds: 1)),
                                      );
                                    } else if (newPin == widget.otp) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Please enter correct pin'),
                                            backgroundColor: AppColor.primary,
                                            duration: Duration(seconds: 1)),
                                      );
                                    } else if (_newPassC.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Please enter password'),
                                            backgroundColor: AppColor.primary,
                                            duration: Duration(seconds: 1)),
                                      );
                                    } else {
                                      forgotPassword();
                                    }
                                  } catch (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Verification failed:'),
                                          backgroundColor: AppColor.primary,
                                          duration: Duration(seconds: 1)),
                                    );
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColor.pinkDark,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColor.white,
                                          ),
                                        )
                                      : Center(
                                          child: NewText(
                                            textFuture: Provider.of<
                                                    LanguageProvider>(context)
                                                .translate("Forgot Password"),
                                            styles: const TextStyle(
                                                color: AppColor.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  try {
                                    if (newPin == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Please enter  pin'),
                                            backgroundColor: AppColor.primary,
                                            duration: Duration(seconds: 1)),
                                      );

                                    } else if (newPin == widget.otp) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Please enter correct pin'),
                                            backgroundColor: AppColor.primary,
                                            duration: Duration(seconds: 1)),
                                      );

                                    } else {
                                      if (widget.isTrue == true) {
                                        await loginOtpApi();
                                      } else {
                                        await verifyOtpApi();
                                      }
                                    }
                                  } catch (error) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Verification failed: '),
                                          backgroundColor: AppColor.primary,
                                          duration: Duration(seconds: 1)),
                                    );

                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColor.pinkDark,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColor.white,
                                          ),
                                        )
                                      : Center(
                                          child: NewText(
                                            textFuture:
                                                Provider.of<LanguageProvider>(
                                                        context)
                                                    .translate("Verify OTP"),
                                            styles: const TextStyle(
                                                color: AppColor.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String? mobile;
  String? userId;

  Future<void> verifyOtpApi() async {
    setState(() {
      isLoading = true;
    });

    var headers = {'Cookie': 'ci_session=4ikbq9d7b4ndg65sg5tntnlq1vj2uhi0'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Endpoints.baseUrl}register_user'));
    request.fields.addAll({
      'mobile': widget.mobile.toString(),
      'otp': widget.otp.toString(),
      'username': widget.name.toString(),
      'email': widget.email.toString(),
      'password': widget.password.toString(),
      'country_code': widget.countryCode.toString()
    });
    print(request.fields);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['error'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("${finalResult['message']}"),
              backgroundColor: AppColor.primary,
              duration: const Duration(seconds: 1)),
        );
        setState(() {
          isLoading = false;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();

        userId = finalResult['data']['id'];
        mobile = finalResult['data']['mobile'];
        prefs.setString('userid', userId.toString());
        prefs.setString('mobile', mobile.toString());

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(
                      title: '',
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("${finalResult['message']}"),
              backgroundColor: AppColor.primary,
              duration: const Duration(seconds: 1)),
        );
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });

      print(response.reasonPhrase);
    }
  }

  Future<void> loginOtpApi() async {
    setState(() {
      isLoading = true;
    });

    var headers = {'Cookie': 'ci_session=4ikbq9d7b4ndg65sg5tntnlq1vj2uhi0'};
    var request =
        http.MultipartRequest('POST', Uri.parse('${Endpoints.baseUrl}login'));
    request.fields.addAll({
      'mobile': widget.mobile.toString(),
      'otp': widget.otp.toString(),
      'type': 'mobile',
      'country_code': widget.countryCode.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['error'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("${finalResult['message']}"),
              backgroundColor: AppColor.primary,
              duration: const Duration(seconds: 1)),
        );
        setState(() {
          isLoading = false;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();

        userId = finalResult['data']['id'];
        mobile = finalResult['data']['mobile'];
        prefs.setString('userid', userId.toString());
        prefs.setString('mobile', mobile.toString());

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(
                      title: '',
                    )));
      } else {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("${finalResult['message']}"),
              backgroundColor: AppColor.primary,
              duration: const Duration(seconds: 1)),
        );
      }
    } else {
      setState(() {
        isLoading = false;
      });

      print(response.reasonPhrase);
    }
  }

  Future<void> resendOtpApi() async {
    var headers = {'Cookie': 'ci_session=m54j9f56lbe2s08ab64ecotv5o427kj9'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Endpoints.baseUrl}resend_otp'));
    request.fields.addAll({
      'mobile': widget.mobile.toString(),
      'country_code': widget.countryCode!
    });
    debugPrint("mobile  ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['error'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("${finalResult['message']}"),
              backgroundColor: AppColor.primary,
              duration: const Duration(seconds: 1)),
        );
        widget.otp = finalResult['data']['otp'];
        setState(() {});
        print("widget.otp${widget.otp}");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("${finalResult['message']}"),
              backgroundColor: AppColor.primary,
              duration: const Duration(seconds: 1)),
        );
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> forgotPassword() async {
    var headers = {'Cookie': 'ci_session=m54j9f56lbe2s08ab64ecotv5o427kj9'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Endpoints.baseUrl}forgot_password'));
    request.fields.addAll({
      'mobile': widget.mobile!.replaceAll(" ", ""),
      'otp': "${widget.otp}",
      'password': _newPassC.text
    });
    debugPrint("mobile  ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['error'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("${finalResult['message']}"),
              backgroundColor: AppColor.primary,
              duration: const Duration(seconds: 1)),
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("${finalResult['message']}"),
              backgroundColor: AppColor.primary,
              duration: const Duration(seconds: 1)),
        );
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
