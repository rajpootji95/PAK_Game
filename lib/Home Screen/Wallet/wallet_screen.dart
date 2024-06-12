
import 'package:flutter/material.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:provider/provider.dart';

import '../../Utils/myWidget.dart';
import '../../provider/languageProvider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {


  List<String> textList = ["Deposit",'Withdraw','Deposit History','Withdraw history'];
  List<IconData> iconList = [Icons.wallet,Icons.widgets,Icons.wallet,Icons.wallet];
  List<String> imageUrls = ['assets/images/wallet_deposit.jpeg','assets/images/wallet_withdraw.jpeg','assets/images/wallet_deposit_history.jpeg','assets/images/wallet_withdraw_history.jpeg'];
  List<String> imageGridUrls = ["assets/images/8.png",'assets/images/tb.png','assets/images/9.png','assets/images/m.png'
    ,'assets/images/Jcb.png','assets/images/saba.png','assets/images/tb.png','assets/images/evo.png','assets/images/jili.png',
    'assets/images/bet365.png','assets/images/pp.png','assets/images/pg.png'];
  List<String> gridTextList =['Lottery','TB_Chess','Wicket_9','MG','JDB','SABA','TB','EVO_Video','JILI',"Card365",'PP','PG'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.redLight,
                ),
              ),
              SizedBox(

              ),
            ],
          ),
          Align(
              alignment: Alignment.topCenter,
              child:Padding(
                padding: const EdgeInsets.only(top: 28),
                child: Column(
                  children: [
                     NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Wallet"),styles: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                       color: AppColor.white
                     )
                    ),

                    const SizedBox(height: 2,),
                    const Icon(Icons.wallet,color: Colors.white,size: 24,),

                    const SizedBox(height: 2,),
                    const Text("Rs.0.00",style: TextStyle(color: Colors.white,fontSize: 20),),
                    NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Total balance"),styles: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColor.white
                    )
                    ),

                    const SizedBox(height: 8,),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:  Column(
                        children: [
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey,
                                    child: CircleAvatar(
                                      radius: 34,
                                      backgroundColor: Colors.white,
                                      child: Text("0 %"),
                                    ),
                                  ),
                                  const Text("Rs. 0.00",style: TextStyle(color: Colors.grey,fontSize: 16),),
                                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Main Wallet "),styles: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    color: AppColor.grey1

                                  )
                                  ),

                                ],
                              ),
                               Column(
                                children: [
                                  const CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey,
                                    child: CircleAvatar(
                                      radius: 34,
                                      backgroundColor: Colors.white,
                                      child: Text("0 %"),
                                    ),
                                  ),
                                  Text("Rs. 0.00",style: TextStyle(color: Colors.grey,fontSize: 16),),
                                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate("3rd Party Wallet"),styles: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.grey1

                                  )
                                  ),

                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            width: double.infinity,
                            height: 32,
                            margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColor.redLight,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child:  Center(child:
                            NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Main Wallet Transfer"),styles: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColor.white

                            )
                            ),
                           ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List<Widget>.generate(4,
                                    (index) => Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  offset: Offset(0, 2),
                                                  blurRadius: 3
                                              )
                                            ]
                                        ),
                                        child: Image.asset(imageUrls[index],scale: 1.2,),
                                      ),
                                      const SizedBox(height: 4,),
                                      NewText(textFuture: Provider.of<LanguageProvider>(context).translate(textList[index]),styles: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,

                                         )
                                      ),
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 6,),
                    SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 24,
                                crossAxisSpacing: 20
                            ),
                            itemCount: imageGridUrls.length,
                            itemBuilder: (_,index){
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(image: AssetImage(imageGridUrls[index])),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 1),
                                          blurRadius: 1
                                      )
                                    ]
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                       const Text("0.00",style: TextStyle(fontSize: 14),),
                                      NewText(textFuture: Provider.of<LanguageProvider>(context).translate(gridTextList[index]),styles: const TextStyle(
                                        fontSize: 12,

                                        )
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ) )
        ],
      ),
    );;
  }
}
