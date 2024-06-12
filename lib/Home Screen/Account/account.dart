
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:pak_games/Home%20Screen/Account/Edit_profile.dart';
import 'package:pak_games/StaticPage/privacy_policy.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

import '../../Api Services/api_end_points.dart';
import '../../Auth/login.dart';
import '../../Model/get_profile_model.dart';
import '../../StaticPage/faq.dart';
import '../../StaticPage/term_and_condition.dart';
import '../../Update Password/change_password.dart';
import '../../Utils/colors.dart';
import '../../Utils/myWidget.dart';
import '../../provider/languageProvider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<String> textList = ["Deposit",'Withdraw','Deposit History','Withdraw history'];
  List<IconData> iconList = [Icons.wallet,Icons.widgets,Icons.wallet,Icons.wallet];
  List<String> imageUrls = ['assets/images/wallet_deposit.jpeg','assets/images/wallet_withdraw.jpeg','assets/images/wallet_deposit_history.jpeg','assets/images/wallet_withdraw_history.jpeg'];
  List<String> imageGridUrls = ["assets/images/8.png",'assets/images/tb.png','assets/images/9.png','assets/images/m.png'
    ,'assets/images/Jcb.png','assets/images/saba.png','assets/images/tb.png','assets/images/evo.png','assets/images/jili.png',
    'assets/images/bet365.png','assets/images/pp.png','assets/images/pg.png'];
  List<String> gridTextList =['Lottery','TB_Chess','Wicket_9','MG','JDB','SABA','TB','EVO_Video','JILI',"Card365",'PP','PG'];

  @override
  initState() {
    super.initState();
    getProfileApi();
  }
  File? _image;
  String ? userId;
  Map<String,String> languageList = {
    'English': 'en',
    'اردو': 'ur'};
  GetProfileModel? getProfileModel;
  Future<void> getProfileApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userid");

    var headers = {
      'Cookie': 'ci_session=jabmg512o22abd8r3bvi86kbgq13ieo5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Endpoints.baseUrl}get_profile'));
    request.fields.addAll({
      'user_id':userId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     var result  = await response.stream.bytesToString();
     var finalResult  = GetProfileModel.fromJson(json.decode(result));
     setState(() {
       getProfileModel = finalResult;

     });

    }
    else {
    print(response.reasonPhrase);
    }

  }
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  var profileImage;
  late final String  textToCopy = "78148125";
  String? text;
  @override
  Widget build(BuildContext context)  {

    return Scaffold(
      body: Consumer<LanguageProvider>(
        builder: (context,languageProvider,child) {
          return ListView(
            children: [
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.redLight,
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))
                    ),

                  ),
                 /* getProfileModel?.data == null ? const Center(child: CircularProgressIndicator()):*/  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              //decoration: BoxDecoration(color: AppColor.white,borderRadius:  BorderRadius.circular(50)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  "${getProfileModel?.data?.profileImage}",
                                  fit: BoxFit.fill,
                                   errorBuilder: (_,child,loadingProgress){
                                   return Container(
                                       height: 80,
                                       width: 80,
                                       decoration: BoxDecoration(color: AppColor.white,borderRadius:  BorderRadius.circular(50)),
                                       child: Image.asset("assets/images/pak home.png"));
                                  }
                                ),
                              ),
                            ),


                          ],
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: 150,
                                    child:
                                    NewText(textFuture: Provider.of<LanguageProvider>(context).translate('${getProfileModel?.data?.username}'),styles: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.white,
                                    ) ,),
                                    //Text("${getProfileModel?.data?.username}",style: const TextStyle(color: AppColor.white,fontSize: 18,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),)
                                ),
                                const SizedBox(width: 5,),
                                InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder:(context)=>EditProfileScreen(getProfileModel: getProfileModel,))).then((value) {
                                        getProfileApi();
                                        setState(() {

                                        });
                                      });
                                    },
                                    child: const Icon(Icons.edit_rounded,size: 18,color: AppColor.white,))

                              ],
                            ),
                            Container(
                              width: 150,
                              height: 35,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: AppColor.white.withOpacity(0.4)),
                              child:  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text("UID",style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold),),
                                    const VerticalDivider(color: AppColor.white,),
                                    Text(textToCopy,style: const TextStyle(color: AppColor.white,fontWeight: FontWeight.bold),),
                                    const SizedBox(width: 5,),
                                    InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(text: textToCopy));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Text copied ')),
                                        );
                                      },
                                      child: const Icon(
                                          Icons.copy,
                                          size: 20.0,
                                          color: AppColor.white
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ),
                            //const Text("Last login: 2024-05-28  15:45:45",style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold),)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(

                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                margin:  const EdgeInsets.symmetric(horizontal: 16),
                padding:  const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child:   ListView(
                  children: [
                    ListTile(
                      leading: Image.asset("assets/images/insurance.png",height: 30,width: 23,color: AppColor.primary,),
                      title:
                      NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Privacy Policy'),styles: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ) ,),
                      trailing: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const PrivacyPolicyScreen()));
                          },
                          child: const Icon(Icons.arrow_forward_ios_rounded,size: 19,)),
                    ),
                    Divider(color: AppColor.grey1.withOpacity(0.4),endIndent: 20,indent: 20,),
                    ListTile(
                      leading:  Image.asset("assets/images/terms-and-conditions.png",height: 25,width: 22,color: AppColor.primary,),
                      title: NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Terms & Conditions'),styles: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ) ,),
                      trailing: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const TermAndCondition()));
                          },
                          child: const Icon(Icons.arrow_forward_ios_rounded,size: 19,)),
                    ),
                    Divider(color: AppColor.grey1.withOpacity(0.4),endIndent: 20,indent: 20,),
                    ListTile(
                      leading: Image.asset("assets/images/conversation.png",height: 30,width: 25,color: AppColor.primary,),
                      title:  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('FAQ'),styles: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ) ,),
                      trailing: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const FeqScreen()));
                          },
                          child: const Icon(Icons.arrow_forward_ios_rounded,size: 19,)),
                    ),
                    Divider(color: AppColor.grey1.withOpacity(0.4),endIndent: 20,indent: 20,),

                    ListTile(
                      leading: Image.asset("assets/images/insurance.png",height: 30,width: 23,color: AppColor.primary,),
                      title:
                      NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Change Password'),styles: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ) ,),
                      trailing: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChangePassword()));
                          },
                          child: const Icon(Icons.arrow_forward_ios_rounded,size: 19,)),
                    ),
                    Divider(color: AppColor.grey1.withOpacity(0.4),endIndent: 20,indent: 20,),
                     buildDropdownOption(Provider.of<LanguageProvider>(context).translate('Language'), selectedLanguage, (value)async {
                         selectedLanguage = value;
                         SharedPreferences prefs = await SharedPreferences.getInstance();
                         prefs.setString('selectedLanguage', selectedLanguage!);
                       languageProvider.setLanguage('$selectedLanguage');
                       Provider.of<LanguageProvider>(context, listen: false)
                           .translate("Hello man ok")
                           .then((translatedText) {
                         debugPrint("Translated Text: $translatedText");
                       });

                     }),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: (){
                        openLogoutDialog();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        decoration: BoxDecoration(

                            border: Border.all(color: AppColor.grey1.withOpacity(0.4) ),borderRadius: BorderRadius.circular(30)

                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            const Icon(Icons.power_settings_new_outlined,color: AppColor.grey1,),
                            const SizedBox(width: 5,),

                            NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Log out'),styles: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ) ,),
                          ],),
                      ),
                    ),

                  ],
                ),
              ),


            ],
          );
        },
      ),
    );
  }

  String? selectedLanguage;
  Widget buildDropdownOption(Future<String> titleFuture, String? value, Function(String?) onChanged) {
    return FutureBuilder<String>(
      future: titleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ListTile(
            title: Text(
              'Loading...', // Placeholder text while waiting for translation
              style:  TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff1A172C),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return ListTile(
          leading: const Icon(Icons.language,color: AppColor.primary,),
          title: Text(
            snapshot.data!,

          ),
          trailing: DropdownButton<String>(
            value: value,
            underline: const SizedBox.shrink(),
            icon: const Icon(Icons.arrow_forward_ios_outlined,size: 18),
            onChanged: onChanged,
            items: languageList.keys
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: languageList[value],
                child:
                Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }
  openLogoutDialog(){
    return showDialog(context: context, builder: (context){
      return StatefulBuilder(builder: (context,setState){
        return AlertDialog(
          title:   NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Are you sure, You want to logout ?'),styles: const TextStyle(
              color: AppColor.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Lora'
          ) ,),

          content: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: ()async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('userid', "");
                  // Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));

                  setState((){
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.green,
                  ),
                  child:
                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Confirm'),styles: const TextStyle(
                      color: AppColor.white,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Lora'
                  ) ,),
                ),
              ),
              const SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.red,
                  ),
                  child:
                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Cancel'),styles: const TextStyle(
                      color: AppColor.white,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Lora'
                  ) ,),

                ),
              ),
            ],
          ),
        );
      });
    });
  }

}
