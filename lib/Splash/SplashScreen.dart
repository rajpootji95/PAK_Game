import 'package:flutter/material.dart';
import 'package:pak_games/Auth/login.dart';
import 'package:pak_games/Home%20Screen/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }
  String? userId;
  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getString("userid");
   print(userId);
    if(userId == null||userId ==''){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }else{
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyHomePage(title: '')));
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/pak home.png',scale: 1.5,),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
