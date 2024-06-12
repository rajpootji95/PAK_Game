import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:provider/provider.dart';

import '../../Utils/myWidget.dart';
import '../../provider/languageProvider.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {


  List<Color> colors = [AppColor.black,AppColor.green,AppColor.redLight,AppColor.black,];

  List<String> textList = ["number of register",'Deposit number','Deposit amount','Number of people making\nfirst deposit'];
  String textToCopy = '8741582';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: ListView(
        children: [
          // Container(
          //   height: 40,
          //   width: double.infinity,
          //   color: AppColor.white,
          //   child:  Center(
          //     child:  NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Agency"),styles: const TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.bold,
          //
          //     ) ,),
          //    // Text("Agency",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          //   ),
          // ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: AppColor.primary
                    ),
                  ),
                   const SizedBox(

                      ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                  child:Padding(
                    padding: const EdgeInsets.only(top: 28),
                    child: Column(
                      children: [
                        const Text("0",style: TextStyle(color: Colors.white,fontSize: 20),),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Yesterday's total Commission"),styles: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                              color: Colors.white

                          ) ,),

                          /*const Text("Yesterday's total Commission",style: TextStyle(color: Colors.white),),*/
                        ),
                        const SizedBox(height: 4,),
                        NewText(textFuture: Provider.of<LanguageProvider>(context).translate("upgrade the level to increase commission volume"),styles: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white

                        ) ,),

                        const SizedBox(height: 8,),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                width: double.infinity,
                                color: AppColor.shadowGrey,
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.person,   color: AppColor.primary,),
                                        const SizedBox(width: 4,),
                                        NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Direct Subordinates"),styles: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          color: AppColor.white,

                                        ) ,),

                                      ],
                                    ),
                                     Row(
                                      children: [
                                        const Icon(Icons.person,   color: AppColor.primary,),
                                        const SizedBox(width: 4,),
                                        NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Team Subordinates"),styles: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.white,


                                        ) ,),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: List<Widget>.generate(4,
                                              (index) => Column(
                                                children: [
                                                  Text("0",style: TextStyle(fontSize: 16,color: colors[index]),),
                                                  const SizedBox(height: 6,),
                                                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate(textList[index]),styles: const TextStyle(
                                                     fontSize: 12,color: AppColor.grey1
                                                  ) ,),
                                                ],
                                              )),
                                    ),
                                    VerticalDivider(color: AppColor.grey,thickness: 2,width: 2,),
                                    Column(
                                      children: List<Widget>.generate(4,
                                              (index) => Column(
                                            children: [
                                              Text("0",style: TextStyle(fontSize: 16,color: colors[index]),),
                                              const SizedBox(height: 6,),
                                              NewText(textFuture: Provider.of<LanguageProvider>(context).translate(textList[index]),styles: const TextStyle(
                                                  fontSize: 12,color: AppColor.grey1
                                              ) ,),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),

                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          height: 32,
                          margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child:  Center(child:
                          NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Invitation Link"),styles: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColor.white
                          )
                         ),

                          ),
                        ),
                        const SizedBox(height: 6,),
                        SizedBox(
                          height: 240,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Container(
                                height: 80,
                                margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const[
                                    BoxShadow(
                                      color: AppColor.customGrey,
                                      offset: Offset(0, 2),
                                      blurRadius: 4
                                    )
                                  ]
                                ),
                                child:  Row(
                                  children: [
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
                                          color: AppColor.primary
                                      ),
                                    ),
                                     const SizedBox(width: 6,),
                                    NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Copy Invitation Code"),styles: const TextStyle(
                                    )
                                    ),
                                    // const Text("Copy Invitation Code")
                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: AppColor.customGrey,
                                          offset: Offset(0, 2),
                                          blurRadius: 4
                                      )
                                    ]
                                ),
                                child:  Row(
                                  children: [
                                    const Icon(Icons.list_alt,  color: AppColor.primary,),
                                    const SizedBox(width: 6,),
                                    NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Subordinate Data"),styles: const TextStyle()),

                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: AppColor.customGrey,
                                          offset: Offset(0, 2),
                                          blurRadius: 4
                                      )
                                    ]
                                ),
                                child:  Row(
                                  children: [
                                    const Icon(Icons.currency_rupee,   color: AppColor.primary,),
                                    const SizedBox(width: 6,),
                                    NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Commission Details"),styles: const TextStyle()),

                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: AppColor.customGrey,
                                          offset: Offset(0, 2),
                                          blurRadius: 4
                                      )
                                    ]
                                ),
                                child:  Row(
                                  children: [
                                    const Icon(Icons.insert_invitation,   color: AppColor.primary,),
                                    const SizedBox(width: 6,),
                                    NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Invitation rules"),styles: const TextStyle()),

                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: AppColor.customGrey,
                                          offset: Offset(0, 2),
                                          blurRadius: 4
                                      )
                                    ]
                                ),
                                child:  Row(
                                  children: [
                                    const Icon(Icons.support_agent,   color: AppColor.primary,),
                                    const SizedBox(width: 6,),
                                    NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Agent Line Customer Service"),styles: const TextStyle()),

                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: AppColor.customGrey,
                                          offset: Offset(0, 2),
                                          blurRadius: 4
                                      )
                                    ]
                                ),
                                child:  Row(
                                  children: [
                                    const Icon(Icons.currency_exchange_outlined,   color: AppColor.primary,),
                                    const SizedBox(width: 6,),
                                    NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Rebate Ratio"),styles: const TextStyle()),
                                    
                                  ],
                                ),
                              ),
                              Container(
                                clipBehavior: Clip.hardEdge,
                                margin: const EdgeInsets.symmetric(horizontal: 16),
                                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                     Row(
                                      children: [
                                        const Icon(Icons.stars_rounded,   color: AppColor.primary,),
                                        const SizedBox(width: 4,),
                                        NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Promotion data"),styles: const TextStyle()),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Column(
                                      children: [
                                        IntrinsicHeight(
                                          child: Row(
                                            children: [
                                             Expanded(
                                              child: Column(
                                                children: [
                                                  const   Text("0",style: TextStyle(fontSize: 16,),),
                                                  const  SizedBox(height: 6,),
                                                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate("This Week"),styles: const TextStyle(
                                                      fontSize: 12,color: AppColor.grey1
                                                    )
                                                  ),
                                                ],
                                              ),
                                            ),
                                            VerticalDivider(color: AppColor.grey,thickness: 2,width: 2,),
                                             Expanded(
                                              child: Column(
                                                children: [
                                                  const Text("0",style: TextStyle(fontSize: 16),),
                                                  const  SizedBox(height: 6,),
                                                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Total Commission"),styles: const TextStyle(
                                                      fontSize: 12,color: AppColor.grey1
                                                  )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],),
                                        ),
                                        const SizedBox(height: 20,),
                                        IntrinsicHeight(
                                          child: Row(
                                            children: [
                                             Expanded(
                                              child: Column(
                                                children: [
                                                  const  Text("0",style: TextStyle(fontSize: 16,),),
                                                  const SizedBox(height: 6,),
                                                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Direct Subordinate"),styles: const TextStyle(
                                                      fontSize: 12,color: AppColor.grey1
                                                  )
                                                  ),
                                                ],
                                              ),
                                            ),
                                            VerticalDivider(color: AppColor.grey,thickness: 2,width: 2,),
                                             Expanded(
                                              child: Column(
                                                children: [
                                                  const Text("0",style: TextStyle(fontSize: 16),),
                                                  const SizedBox(height: 6,),
                                                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Total Number of\nSubordinates\nin the team"),styles: const TextStyle(
                                                      fontSize: 12,color: AppColor.grey1
                                                  )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ) )
            ],
          )
        ],
      ),
    );
  }
}
