import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pak_games/Home%20Screen/Home%20Widget/home_widget.dart';

import '../Utils/colors.dart';

class ThankScreen extends StatefulWidget {
  const ThankScreen({super.key});

  @override
  State<ThankScreen> createState() => _ThankScreenState();
}

class _ThankScreenState extends State<ThankScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
          // SvgPicture.asset("images/thankImage.svg"),
            const SizedBox(
              height: 10,
            ),
            //SvgPicture.asset("images/success.svg"),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Thank You!",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Your booking has been successful",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff555555)),
            ),
            const SizedBox(
              height: 38,
            ),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeWidget()),
                      (route) => false);
                },
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 17,
                      color: AppColor.primary,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      "Go to Back",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff00ADAD)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
