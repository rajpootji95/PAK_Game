import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:provider/provider.dart';

import '../../Utils/myWidget.dart';
import '../../provider/languageProvider.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {


  List<String> textList = ["Activity\nAward", 'Betting\nRebate', 'Super\nJackpot'];
  List<String> nameTextList = ["New Member 1st Recharge Bonus",'Recharge and Get Daily-Check in Bonus'
    ,'Invitation Bonus', 'Winning Streak Bonus','Aviator High Betting Award', 'YouTube Creative Video',
    'Lucky "10" Days of Interest' ,'Mysterious Gifts',
  ];
  List<String> imageGridUrls = ['assets/images/Activity/new member.png','assets/images/Activity/dailiy.png','assets/images/Activity/invait.png',
    'assets/images/Activity/winGobanner.png','assets/images/Activity/fly.png','assets/images/Activity/youtube.png','assets/images/Activity/10day.png','assets/images/Activity/giftqqq.png',
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.primary ,
                  borderRadius: BorderRadius.circular(0)
              ),
              child: Column(
                children: [
                  const SizedBox(height: 5,),
                  Image.asset('assets/images/Activity/packlogoActivity.png',scale: 1.7,),
                  const SizedBox(height: 20,width: 10,),
                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Activity \n  Please remember to follow the event page We will \n  launch user feedback activities from time to time'),styles: const TextStyle(
                      color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 13
                  ) ,),
                 // const Text("  Activity \n  Please remember to follow the event page We will \n  launch user feedback activities from time to time ",style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold))
                ],
              ),


            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3,
                        (index) => Column(
                          children: [
                            Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.grey,
                                    offset: Offset(0,2),
                                    blurRadius: 2,
                                  )
                                ]
                              ),
                              child: Center(
                                child: Image.asset('assets/images/Activity/activitHome.png'),
                              ),
                            ),
                            Text(
                              textList[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ) ),
              ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween
                  ,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 72,
                          width: 72,
                          decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.grey,
                                  offset: Offset(0,2),
                                  blurRadius: 2,
                                )
                              ]
                          ),
                          child: Center(
                            child: Image.asset('assets/images/Activity/activitHome.png'),
                          ),
                        ),
                        NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Activity \n Award'),styles: const TextStyle(
                            color: AppColor.black,fontWeight: FontWeight.bold,fontSize: 13
                        ) ,),

                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 72,
                          width: 72,
                          decoration: BoxDecoration(
                              color: AppColor.yellow,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.grey,
                                  offset: Offset(0,2),
                                  blurRadius: 2,
                                )
                              ]
                          ),
                          child: Center(
                            child: Image.asset('assets/images/Activity/acitiviyHome.png'),
                          ),
                        ),
                        NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Betting \n rebate'),styles: const TextStyle(
                            color: AppColor.black,fontWeight: FontWeight.bold,fontSize: 13
                        ) ,),

                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 72,
                          width: 72,
                          decoration: BoxDecoration(
                              color: AppColor.lightblue,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.grey,
                                  offset: Offset(0,2),
                                  blurRadius: 2,
                                )
                              ]
                          ),
                          child: Center(
                            child: Image.asset('assets/images/Activity/acivityHomeWin.png'),
                          ),
                        ),
                        NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Super\nJackpot'),styles: const TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 13
                        ) ,),

                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        height: 200,
                        color: AppColor.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                 // color: Colors.red,
                                 //  gradient: LinearGradient(
                                 //      colors: [ Colors.red, AppColor.white],
                                 //      begin: Alignment.topCenter,
                                 //      end: Alignment.bottomCenter
                                 //  )
                              ),
                              child: Image.asset("assets/images/Activity/gift.png"),
                            ),
                            NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Gifts'),styles: const TextStyle(
                                fontWeight: FontWeight.bold
                            ) ,),
                            NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Enter Redemtion Code to Receive gift rewards'),styles: const TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 12
                            ) ,),


                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Flexible(
                      child: Container(
                        height: 200,
                        color: AppColor.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                // color: Colors.red,
                                //  gradient: LinearGradient(
                                //      colors: [ Colors.red, AppColor.white],
                                //      begin: Alignment.topCenter,
                                //      end: Alignment.bottomCenter
                                //  )
                              ),
                              child: Image.asset("assets/images/Activity/attetd.png"),
                            ),
                            NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Attendance Bonus'),styles: const TextStyle(
                                fontWeight: FontWeight.bold
                            ) ,),
                            NewText(textFuture: Provider.of<LanguageProvider>(context).translate('The More Consecutive Days you sign in, the higher the reward will be'),styles: const TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 12
                            ) ,),


                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: List<Widget>.generate(
                    nameTextList.length,
                        (index) =>
                        Column(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColor.shadowGrey,
                                      offset: Offset(0, 2),
                                      blurRadius: 3,
                                    )
                                  ]
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 120,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      // color: Colors.red,
                                    ),
                                    child: Image.asset(imageGridUrls[index],fit: BoxFit.fill,),
                                  ),
                                  const SizedBox(height: 3,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child:  NewText(textFuture: Provider.of<LanguageProvider>(context).translate(nameTextList[index]),styles: const TextStyle(
                                        fontWeight: FontWeight.bold,fontSize: 12
                                    ) ,),
                                  ),
                                  const SizedBox(height: 2,),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                          ],
                        ),
                  ),
                ),
                const SizedBox(height: 80,),
              ],
            ),
          )
          ],
        ),
      ),
    );
  }
}
