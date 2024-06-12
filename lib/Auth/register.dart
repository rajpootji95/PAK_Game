import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pak_games/Auth/verify_otp_screen.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:pak_games/api_requests.dart';
import 'package:provider/provider.dart';

import '../Api Services/api_end_points.dart';
import '../Utils/myWidget.dart';
import '../provider/languageProvider.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _value = 1;
  bool isMobile = false;
  bool isSendOtp = false;
  bool isVisible = false;
  bool isLoader = false;
  bool showPassword = false;
  bool isLoading =  false;
 String? mobile;
 int? otp;
 String? countryCode , mobileNumber;
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');


  registerApi() async {
    var headers = {
      'Cookie': 'ci_session=5a9ap44i0tb2dg0g0b67hgraor2fl8gb'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Endpoints.baseUrl}send_otp'));
    request.fields.addAll({
      'mobile': mobileController.text.replaceAll("-", "").replaceAll(" ", ""),
      'type':"1",
      'country_code':countryCode.toString()
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     var result = await response.stream.bytesToString();
     var finalResult  = jsonDecode(result);
     if (finalResult['error'] == true) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("${finalResult['message']}"),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
       );
     } else {
       mobile = finalResult['mobile'];
       otp = finalResult['otp'];

       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("${finalResult['message']}"),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
       );
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => VerifyScreen(
           mobile:mobile,
           otp: otp,
           name: nameController.text,
           email: emailController.text,
           password: passwordController.text,
           countryCode: countryCode,
         )),
       );
     }
    }
    else {
    print(response.reasonPhrase);
    }

  }
  String name = "Enter Name";
  String email = "Enter Email";
  String password = "Enter Password";
  String mobileNo = "Enter Mobile Number";
  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context).translate('Enter Name').then((value){
      name = value;

    });
    Provider.of<LanguageProvider>(context).translate('Enter Email').then((value){
      email = value;

    });
    Provider.of<LanguageProvider>(context).translate('Enter Password').then((value){
      password = value;

    });
    Provider.of<LanguageProvider>(context).translate('Enter Mobile Number').then((value){
      mobileNo = value;

    });

    return  SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox( height: MediaQuery.of(context).size.height/9.0),
            Image.asset('assets/images/pak home.png',scale: 1.5,),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
              Column(children: [
                  /// email login section
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [

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
                              controller: nameController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(

                                  contentPadding:
                                  const EdgeInsets.only(top: 8),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText:name,
                                  prefixIcon: Icon(Icons.person_outline,color: AppColor.pinkDark,)
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 17),
                          child: InternationalPhoneNumberInput(
                            maxLength: 12,
                            onInputChanged: (PhoneNumber number) {
                                countryCode = number.dialCode;
                                mobileNumber = number.phoneNumber;
                            },
                            onInputValidated: (bool value) {

                                print(value ? 'Valid' : 'Invalid');

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
                                 hintText: password,
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
                                    color: AppColor.pinkDark,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                       SizedBox(height: 20,),
                        InkWell(
                          onTap: () {

                            if(nameController.text.isEmpty){
                              Fluttertoast.showToast(msg: "Enter your name",backgroundColor: AppColor.primary);
                              return null;
                            }else if(mobileController.text.isEmpty){
                              Fluttertoast.showToast(msg: "Enter your mobile number",backgroundColor: AppColor.primary);
                              return null;
                            }else if(emailController.text.isEmpty){
                              Fluttertoast.showToast(msg: "Enter your email",backgroundColor: AppColor.primary);
                              return null;
                            }
                            else if(passwordController.text.isEmpty){
                              Fluttertoast.showToast(msg: "Enter your password",backgroundColor: AppColor.primary);
                              return null;
                            }
                            else{
                              registerApi();
                              setState(() {
                                isLoading = true;
                              });
                            }

                            // Navigator.push(context, MaterialPageRoute(builder:(context)=> MyStatefulWidget()));

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
                                : NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Register'),styles: const TextStyle(
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
                ]),

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
                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Already have an account?'),styles: const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                  ) ,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                     // Get.to(const SignUpScreen());
                    },
                    child: NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Sign In'),styles: const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      color: AppColor.primary
                    ) ,),


                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

}
