import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pak_games/Api%20Services/api_end_points.dart';
import 'package:pak_games/Auth/register.dart';
import 'package:pak_games/Auth/verify_otp_screen.dart';
import 'package:pak_games/Home%20Screen/homeScreen.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Forgot Password/forgot_password.dart';
import '../Utils/myWidget.dart';
import '../provider/languageProvider.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int _value = 1;
  bool isMobile = false;
  bool isSendOtp = false;
  bool isVisible = false;
  bool isLoader = false;
  bool showPassword = false;
  bool isLoading =  false;

  String? mobile;
  String? userId,mobileNumber,countryCode;
  int? otp;

  Future<void> loginWithMobileApi() async {
    setState(() {
      isLoading =  true;
    });

    var headers = {
      'Cookie': 'ci_session=5nbd4rujnmj58327kb67h560njukte8i'
    };
    var request = http.MultipartRequest('POST', Uri.parse("${Endpoints.baseUrl}send_otp"));
    request.fields.addAll({
      'mobile':mobileController.text.replaceAll("-", "").replaceAll(" ", ""),
      'type':"0",
      'country_code':countryCode!
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if(finalResult['error'] == true){
        setState(() {
          isLoading =  false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${finalResult['message']}"),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
        );
      }else{
        setState(() {
          isLoading =  false;
        });
        mobile = finalResult['mobile'];
        otp = finalResult['otp'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${finalResult['message']}"),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
        );

        Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyScreen(mobile: mobile,otp: otp,email: emailController.text,password: passwordController.text,isTrue: true,countryCode: countryCode,)));
        mobileController.clear();
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
  Future<void> loginWithEmailApi() async {
    setState(() {
      isLoading =  true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=5nbd4rujnmj58327kb67h560njukte8i'
    };
    var request = http.MultipartRequest('POST', Uri.parse("${Endpoints.baseUrl}login"));
    request.fields.addAll({
    'email':emailController.text,
    'type':"email",
    'password':passwordController.text
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if(finalResult['error'] == true){
        setState(() {
          isLoading =  false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${finalResult['message']}"),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
        );
      }else{
        setState(() {
          isLoading =  false;
        });
        userId = finalResult['data']['id'];
        mobile = finalResult['data']['mobile'];
        prefs.setString('userid', userId.toString());
        prefs.setString('mobileNO', mobile.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${finalResult['message']}"),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
        );
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage(title: "")));
         emailController.clear();
         passwordController.clear();
      }

    }
    else {
      setState(() {
        isLoading =  false;
      });
      print(response.reasonPhrase);
    }

  }
  String email = "Enter Email";
  String password = "Enter Password";
  String mobileNo = "Enter Mobile Number";

  Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Exit App'),styles: const TextStyle(
            color: AppColor.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Lora'
        ) ,),
        content: NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Do you really want to exit the app?'),styles: const TextStyle(
            color: AppColor.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Lora'
        ) ,),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: NewText(textFuture: Provider.of<LanguageProvider>(context).translate('No'),styles: const TextStyle(
                color: AppColor.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Lora'
            ) ,),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Yes'),styles: const TextStyle(
                color: AppColor.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Lora'
            ) ,),

          ),
        ],
      ),
    ) ??
        false;
  }

  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }
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
    Provider.of<LanguageProvider>(context).translate('Enter Email').then((value){
      email = value;
   // setState(() {
   //
   //  });
    });
    Provider.of<LanguageProvider>(context).translate('Enter Password').then((value){
      password = value;

    });
    Provider.of<LanguageProvider>(context).translate('Enter Mobile Number').then((value){
      mobileNo = value;

    });
    return  WillPopScope(
      onWillPop: () =>  showExitConfirmationDialog(context),
          //openLogoutDialog(),
      child:_isConnected
          ? SafeArea(
        child: Scaffold(
          body:
           ListView(
            children: [
              SizedBox( height: MediaQuery.of(context).size.height/6.0),
              Image.asset('assets/images/pak home.png',scale: 1.5,),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 1,
                        fillColor: MaterialStateColor.resolveWith(
                                (states) => AppColor.maroon),
                        activeColor: AppColor.maroon,
                        groupValue: _value,
                        onChanged: (int? value) {
                          setState(() {
                            _value = value!;
                            isMobile = false;
                          });
                        },
                      ),
                      NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Email'),styles: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ) ,),
                      const SizedBox(
                        height: 10,
                      ),
                      Radio(
                          value: 2,
                          fillColor: MaterialStateColor.resolveWith(
                                  (states) => AppColor.maroon),
                          activeColor: AppColor.maroon,
                          groupValue: _value,
                          onChanged: (int? value) {
                            setState(() {
                              _value = value!;
                              isMobile = true;
                            });
                          }),
                      // SizedBox(width: 10.0,),
                        NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Mobile Number'),styles: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ) ,),
                    ],
                  ),
                  isMobile == false
                      ? Column(children: [
                    /// email login section
                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Material(
                              elevation: 0,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: MediaQuery.of(context).size.width/1.1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColor.pinkDark)
                                ),
                                height: 50,
                                child: TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(

                                      contentPadding:
                                      const EdgeInsets.only(top: 8),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: email,
                                      prefixIcon: Icon(Icons.email_outlined,color: AppColor.pinkDark,)
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Material(
                              elevation: 0,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColor.pinkDark)
                                ),
                                width: MediaQuery.of(context)
                                    .size
                                    .width /
                                    1.1,
                                height: 50,
                                child: TextField(
                                  obscureText: isVisible ? false : true,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.only(top: 8),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText:  password,
                                    prefixIcon: Icon(Icons.lock_outlined,color: AppColor.pinkDark,),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isVisible ? isVisible = false : isVisible = true;
                                        });
                                      },
                                      icon: Icon(
                                        isVisible
                                            ? Icons.remove_red_eye
                                            : Icons.visibility_off,
                                        color: AppColor.pinkDark,size: 19,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgetPassword()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child:  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Forgot Password'),styles: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primary,
                                    ) ,),

                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),

                            InkWell(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder:(context)=> MyStatefulWidget()));

                                if(emailController.text == ""){

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Email is required')),
                                  );

                                  return;
                                }if(passwordController.text == ""){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Password is required')),
                                  );

                                }else{
                                  loginWithEmailApi();
                                  setState(() {
                                    isLoader = true;
                                  });
                                }
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context)
                                    .size
                                    .width /
                                    1.1,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  color: AppColor.pinkDark,
                                ),
                                child: isLoading == true
                                    ? const Center(
                                  child:
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                                    :
                                NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Login'),styles: const TextStyle(
                                   fontSize: 16,
                                      fontWeight:
                                      FontWeight.w600,
                                      color: AppColor.white
                                ) ,),

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])

                      : const SizedBox.shrink(),
                  const SizedBox(height: 30,),
                  isMobile == true
                      ? Column(
                    children: [
                      // Material(
                      //   elevation: 0,
                      //   borderRadius: BorderRadius.circular(10),
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width/1.1,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(color: AppColor.pinkDark)
                      //     ),
                      //     height: 50,
                      //     child: TextFormField(
                      //       maxLength: 10,
                      //       keyboardType: TextInputType.number,
                      //       controller: mobileController,
                      //       decoration:   InputDecoration(
                      //         prefixIcon: Icon(Icons.call,color: AppColor.pinkDark),
                      //         counterText: "",
                      //         contentPadding: const EdgeInsets.only(top: 12,left: 10),
                      //         border: const OutlineInputBorder(
                      //             borderSide: BorderSide.none),
                      //         hintText: mobileNo,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(right: 17),
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
                            hintText: mobileNo,
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




                        const SizedBox(height: 50,),
                      InkWell(
                        onTap: (){
                          setState((){
                            isLoading = true;
                          });
                          if(mobileController.text.isNotEmpty /*&& mobileController.text.length > 10 && mobileController.text.length < 14*/){
                            loginWithMobileApi();

                          }else{
                            setState((){
                              isLoading = false;
                            });
                            Fluttertoast.showToast(msg: "Please enter valid mobile number!",);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context)
                              .size
                              .width /
                              1.1,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10),
                            color: AppColor.pinkDark,
                          ),
                          child: isLoading == true
                              ? const Center(
                            child:
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                              :  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Send OTP'),styles: const TextStyle(
                              fontSize: 16,
                              fontWeight:
                              FontWeight.w600,
                              color: AppColor.white
                          ) ,),


                        ),
                      ),
                    ],
                  )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),

            ],
          ),
            bottomSheet: Container(
              color: AppColor.white,
              child: Padding(
                padding:  const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Don't have an account?"),styles: const TextStyle(
                        fontWeight: FontWeight.bold
                    ) ,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterScreen()));

                      },
                      child: NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Sign Up"),styles: const TextStyle(
                          color: AppColor.primary, fontWeight: FontWeight.bold
                      ) ,),

                    ),
                  ],
                ),
              ),
            )
        ),
      ): Scaffold(body: Center(child: Image.asset('assets/images/internet.png',)))

    );
  }
  String initialCountry = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
}
