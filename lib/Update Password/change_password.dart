import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pak_games/Api%20Services/api_end_points.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/myWidget.dart';
import '../provider/languageProvider.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  final _oldPassC = TextEditingController();
  final _newPassC = TextEditingController();
  final _confirmPassC = TextEditingController();
  bool isLoading = false;
  String oldPass = "Enter Old Password";
  String newPass = "Enter New Password";
  String confPass = "Enter Confirm Password";


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
    Provider.of<LanguageProvider>(context).translate('Enter Old Password').then((value){
      oldPass = value;

    });
    Provider.of<LanguageProvider>(context).translate('Enter New Password').then((value){
      newPass = value;

    });
    Provider.of<LanguageProvider>(context).translate('Enter Confirm Password').then((value){
      confPass = value;

    });
    return _isConnected? Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColor.white, //change your color here
        ),
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title:
        NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Change Password'),styles: const TextStyle(
            color: AppColor.white,fontSize: 20,fontWeight: FontWeight.w500,fontFamily: 'Lora'
        ) ,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            const SizedBox(height: 50),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _oldPassC,
              obscureText: !_oldPasswordVisible,
              //This will obscure text dynamically
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10),),

                ),
                hintText: oldPass,
                hintStyle: const TextStyle(fontSize: 15),
                prefixIcon: const Icon(
                  Icons.lock_outlined,
                  size: 20,
                    color: AppColor.primary
                ),
                contentPadding: const EdgeInsets.only(top: 0),
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _oldPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppColor.primary, size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      _oldPasswordVisible = !_oldPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _newPassC,
              obscureText: !_newPasswordVisible,
              //This will obscure text dynamically
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                hintText: newPass,
                hintStyle: const TextStyle(fontSize: 15),
                prefixIcon: const Icon(
                  Icons.lock_outlined,
                  size: 20,
                    color: AppColor.primary
                ),
                contentPadding: const EdgeInsets.only(top: 5),
                suffixIcon: IconButton(
                  icon: Icon(
                    _newPasswordVisible ? Icons.visibility : Icons.visibility_off,
                   color: AppColor.primary, size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      _newPasswordVisible = !_newPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _confirmPassC,
              obscureText: !_confirmPasswordVisible,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                   borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                hintText:confPass,
                hintStyle: const TextStyle(fontSize: 15),
                prefixIcon: const Icon(
                  Icons.lock_outlined,
                  size: 20,
                    color: AppColor.primary
                ),
                contentPadding: const EdgeInsets.only(top: 0),
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColor.primary, size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      _confirmPasswordVisible = !_confirmPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    if (_oldPassC.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content:
                        Text('Please Enter old password'),backgroundColor: AppColor.primary,duration: Duration(seconds: 1),
                        ),
                      );
                    } else if (_oldPassC.text.length < 8) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter 8 digit number'),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
                      );
                    } else if (_newPassC.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please Enter new password'),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
                      );
                    } else if (_newPassC.text.length < 8) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter 8 digit number'),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
                      );
                    } else if (_confirmPassC.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(
                            content:
                            Text('Please Enter Confirm password'),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)
                         ),
                      );
                    } else if (_confirmPassC.text != _newPassC.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Password not match'),backgroundColor: AppColor.primary,duration: Duration(seconds: 1),),
                      );
                    } else {
                      changePassword();
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
                        :  Center(
                      child:  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Update Password'),styles: const TextStyle(
                          color: AppColor.white,fontSize: 20,fontWeight: FontWeight.w500,fontFamily: 'Lora'
                      ) ,),
                    ),
                  ),
                )

          ]),
        ),
      ),
    ):Scaffold(body: Center(child: Image.asset('assets/images/internet.png',)));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    _checkInternetConnection();
  }
  String? userId;
  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userid");
    print(userId);
  }
  changePassword() async {
    setState(() {
      isLoading =  true;
    });
    var headers = {
      'Cookie': 'ci_session=1bkkggqcukscr2k2nkf5bfg9f63d3ip4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Endpoints.baseUrl}change_password'));
    request.fields.addAll({
      'user_id': userId.toString(),
      'new_password':_newPassC.text,
      'old_password':_oldPassC.text
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if(finalResult['error'] == false){
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>))
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text("${finalResult['message']}"),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
        );

        setState(() {
          isLoading =  false;
        });
      }else{
        setState(() {
          isLoading =  false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${finalResult['message']}"),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
        );
      }
    }
    else {
      setState(() {
        isLoading =  false;
      });
    print(response.reasonPhrase);
    }

  }
}
