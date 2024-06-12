import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pak_games/Home%20Screen/Account/account.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api Services/api_end_points.dart';
import '../../Model/get_profile_model.dart';
import '../../Utils/myWidget.dart';
import '../../provider/languageProvider.dart';

class EditProfileScreen extends StatefulWidget {
  final GetProfileModel? getProfileModel;
  const EditProfileScreen({super.key,this.getProfileModel});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ImagePicker picker = ImagePicker();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  bool isLoading =  false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  initState(){
    super.initState();
    emailController.text = widget.getProfileModel?.data?.emailId ?? "dev@gmail.com";
    nameController.text = widget.getProfileModel?.data?.username ?? "Deva";
    mobileController.text = widget.getProfileModel?.data?.mobile ?? "7788998984";
    _checkInternetConnection();
  }

  _getFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print('${imageFile}gggggg');
      });
      Navigator.pop(context);
    }
  }
  _getFromCamera() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }
 String ? userId;


  Future<void> updateProfileApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userid");
    setState(() {
      isLoading =  true;
    });
    var headers = {
      'Cookie': 'ci_session=n66d6f98l2tcjmgjbqtv8kajlgllbv5h'
    };
    var request = http.MultipartRequest('POST', Uri.parse("${Endpoints.baseUrl}update_profile"));
    request.fields.addAll({
      'mobile':mobileController.text,
      'username':nameController.text,
      'email':emailController.text,
      'user_id':userId.toString()
    });

    if(_image != null){
      request.files.add(await http.MultipartFile.fromPath('update_profile', _image?.path ?? ""));
    }
    print("this is s so so o s${request.files}");
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${finalResult['message']}"),backgroundColor: AppColor.primary,duration: Duration(seconds: 1)),
        );
        Navigator.pop(context);

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
        centerTitle: true,
        title:
          NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Edit Profile'),styles: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.black
          ) ,)
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Stack(
                  children: [
                    ClipRRect(
                      borderRadius:BorderRadius.circular(100) ,
                      child: Container(
                          decoration:
                          const BoxDecoration(shape: BoxShape.circle),
                          padding: const EdgeInsets.all(2),
                          clipBehavior: Clip.hardEdge,
                          height: 120,
                          width: 120,
                          child: _image != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                 _image!,
                                  // File(image?.path),
                                   fit: BoxFit.fill,
                                ),
                              )
                              :  ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                              height: 120,
                              width: 120,
                              child: Image.network("${widget.getProfileModel?.data?.profileImage}",
                                fit: BoxFit.fill,
                                errorBuilder: (context,_,__){
                                  return Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(color: AppColor.grey,borderRadius:  BorderRadius.circular(50)),
                                      child: Image.asset('assets/images/pak home.png'));
                                },
                              ),
                            ),
                          )
          
                      ),
                    ),
                    Positioned(
                      left: 88,
                      top: 80,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [
                                       Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 0, 5),
                                          child:
                                          NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Change Profile'),styles: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.black
                                          ) ,)

                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.photo_album_rounded,
                                            ),
                                            color: AppColor.green,
                                            iconSize: 30,
                                            onPressed: () async {
                                              _getFromGallery();
          
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                                Icons.camera_alt_rounded),
                                            color: AppColor.green,
                                            iconSize: 30,
                                            onPressed: () async {
                                              _getFromCamera();
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
          
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(50),
                              color: AppColor.green),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: AppColor.white,size: 15,
                          ),
                        ),
                      ),
                    ),
                  ]),
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: formKey,
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
                                hintText: "Entre Name",
                                prefixIcon: Icon(Icons.person_outline,color: AppColor.pinkDark,)
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
                          width: MediaQuery.of(context).size.width/1.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.pinkDark)
                          ),
                          height: 50,
                          child: TextFormField(
                            maxLength: 10,
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            controller: mobileController,
                            decoration:   InputDecoration(
                              prefixIcon: Icon(Icons.call,color: AppColor.pinkDark),
                              counterText: "",
                              contentPadding: const EdgeInsets.only(top: 12,left: 10),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText:  "Enter Mobile Number",
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
                                hintText: "Entre Email",
                                prefixIcon: Icon(Icons.email_outlined,color: AppColor.pinkDark,)
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: (){
                          updateProfileApi();
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
                              :  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Update Profile'),styles: const TextStyle(
                              fontSize: 16,
                              fontWeight:
                              FontWeight.w600,
                              color: AppColor.white
                          ) ,)

                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
          
          
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ):Scaffold(body: Center(child: Image.asset('assets/images/internet.png',)));
  }
}
