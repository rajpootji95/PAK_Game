

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:pak_games/Home%20Screen/Account/account.dart';
import 'package:pak_games/Home%20Screen/Activity%20Screen/activity_screen.dart';
import 'package:pak_games/Home%20Screen/Home%20Widget/home_widget.dart';
import 'package:pak_games/Home%20Screen/Promotion%20Screen/promotion_screen.dart';
import 'package:pak_games/Home%20Screen/Wallet/wallet_screen.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:pak_games/Utils/myWidget.dart';
import 'package:provider/provider.dart';

import '../provider/languageProvider.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 2;
  void _incrementCounter() {

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
  List<Widget> widgets =[
    const HomeWidget(),
    const ActivityScreen(),
    const PromotionScreen(),
    const WalletScreen(),
    const AccountScreen()
  ];

  Future<String> myLabel( Future future) async {
    String label = "";
  await future.then((value) {
    label = value;
    setState(() {

    });
  })  ;
  return label;
  }
   String label1 = "Home";
   String label2 = "Activity";
   String label3 = "Promotion";
   String label4 = "Wallet";
   String label5 = "Account";
  @override
  Widget build(BuildContext context) {
    setState(() {
      Provider.of<LanguageProvider>(context).translate('Home').then((value){
        label1 = value;
        setState(() {

        });
      });
      Provider.of<LanguageProvider>(context).translate('Activity').then((value){
        label2 = value;
        // setState(() {
        //
        // });
      });
      Provider.of<LanguageProvider>(context).translate('Promotion').then((value){
        label3 = value;
        // setState(() {
        //
        // });
      });
      Provider.of<LanguageProvider>(context).translate('Wallet').then((value){
        label4 = value;
        // setState(() {
        //
        // });
      });
      Provider.of<LanguageProvider>(context).translate('Account').then((value){
        label5 = value;
        // setState(() {
        //
        // });
      });
    });

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
    return _isConnected ? SafeArea(
      child: WillPopScope(
        onWillPop: () =>  showExitConfirmationDialog(context),
        child: Scaffold(
          //sbackgroundColor: Color(0XffD9D9D9),
          extendBodyBehindAppBar: selectedIndex == 2,
          appBar: selectedIndex == 2?  AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text("Agency")
            //  NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Agency"),styles: const TextStyle(
            //   color: AppColor.red
            //  )
            // ),
          ): AppBar(
            automaticallyImplyLeading: false,
            // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            elevation: 0,
            title: Image.asset('assets/images/pak home.png',scale: 2.5,),
            actions:  [
              Container(
                height: 30,
                width: 35,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: AppColor.primary),
                  child:  const Icon(Icons.keyboard_arrow_down_rounded,size: 30,color: AppColor.red,)),
                const SizedBox(width: 5,),
               const Icon(Icons.download,size: 30,color: AppColor.red,),
              //Image.asset('assets/images/arrow.png',),
               const SizedBox(width: 10,)
            ],
          ),
          body: widgets[selectedIndex],

          extendBody: true,
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,

            buttonBackgroundColor: AppColor.primary,
            color: AppColor.white,

            index: selectedIndex,
            items:  [
              CurvedNavigationBarItem(
                label: label1,
                // NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Privacy Policy'),styles: const TextStyle(
                //   fontSize: 14,
                //   fontWeight: FontWeight.w400,
                //   color: AppColor.black,
                // ) ,),
                child: Icon(Icons.home,color: selectedIndex!=0? AppColor.primary:AppColor.white,),
                labelStyle: TextStyle(
                    color: selectedIndex==0? Colors.red:AppColor.primary
                ),

              ),
              CurvedNavigationBarItem(
                label:label2,
                labelStyle: TextStyle(
                    color: selectedIndex==1? Colors.red:AppColor.primary
                ),
                child: Icon(Icons.local_activity_outlined,color: selectedIndex!=1? AppColor.primary:AppColor.white,),

              ),
              CurvedNavigationBarItem(
                label: label3,
                child: Icon(Icons.diamond_outlined,color:selectedIndex!=2? AppColor.primary: AppColor.white,),
                labelStyle: TextStyle(
                    color: selectedIndex==2? Colors.red:AppColor.primary
                ),

              ),
              CurvedNavigationBarItem(
                label: label4,
                child: Icon(Icons.wallet,color:selectedIndex!=3? AppColor.primary: AppColor.white,),
                labelStyle: TextStyle(
                    color: selectedIndex==3? Colors.red:AppColor.primary
                ),

              ),
              CurvedNavigationBarItem(
                label: label5,
                child: Icon(Icons.person,color: selectedIndex!=4? AppColor.primary:AppColor.white,),
                labelStyle: TextStyle(
                    color:selectedIndex==4? Colors.red: AppColor.primary
                ),

              )
            ],
            onTap: (index){
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    ): Scaffold(body: Center(child: Image.asset('assets/images/internet.png',)));
  }
}