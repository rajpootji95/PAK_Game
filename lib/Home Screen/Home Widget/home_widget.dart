import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pak_games/Api%20Services/api_end_points.dart';
import 'package:pak_games/Games%20View/games_view.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../Model/get_banner_model.dart';
import '../../Model/get_category_model.dart';
import '../../Utils/myWidget.dart';
import '../../provider/languageProvider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  // int? _currentIndex = 0;


  @override
  initState() {
    super.initState();
    getCatApi();
    getBannerApi();
  }

  getColors(index) {
    Color bgColor = Colors.blue;
    switch (index) {
      case 0:
        bgColor = Colors.blue.shade600;
        break;
      case 1:
        bgColor = Colors.purple;
        break;
      case 2:
        bgColor = Colors.blue.shade400;
        break;
      case 6:
        bgColor = Colors.orange.shade300;
        break;
      case 7:
        bgColor = Colors.pink.shade200;
        break;

    }
    return bgColor;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 75),
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                AppColor.primary,
                AppColor.primary.withOpacity(0.4),

              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 1],
            ),
          ),
          height: 50,
          width: 242,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Image.asset(
                    'assets/images/pak game.png',
                    scale: 1.0,
                  ),
                ),
                const SizedBox(width: 10),
                NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Add to Desktop"),styles: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                    color: Colors.white

                ) ,),

                const VerticalDivider(
                  color: Colors.white,
                  indent: 10,
                  endIndent: 10,
                ),
                Container(
                    decoration: BoxDecoration(border: Border.all(color: AppColor.white,),shape: BoxShape.circle),
                    child: const Icon(Icons.clear,color: AppColor.white,size: 20,))
              ],
            ),
          ),
        )
      ),
      body: getCategoryModel?.data == null ?const Center(child: CupertinoActivityIndicator(color: AppColor.primary,)) :Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // InkWell(
              //   onTap: (){
              //
              //   },
              //   child: Container(
              //     height: 150,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       //color: Colors.red,
              //       borderRadius: BorderRadius.circular(16),
              //       image: const DecorationImage(image: AssetImage('assets/images/banner.png'))
              //     ),
              //
              //
              //   ),
              // ),
              CarouselSlider.builder(
                itemCount: getBannerModel?.data.length ?? 0,
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8,
                  // onPageChanged: (index, reason) {
                  //     _currentIndex = index;
                  // },
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  debugPrint("real index $realIndex");
                  return Center(
                    child: SizedBox(
                      width: double.infinity, // full width container
                      height: 150, // height of the image
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          getBannerModel!.data[index].image ?? "",
                          fit: BoxFit.fill, // fit property set to cover
                          width: double.infinity, // width to full
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: getBannerModel!.data.asMap().entries.map((entry) {
              //     int index = entry.key;
              //     return GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           _currentIndex = index;
              //         });
              //       },
              //       child: Container(
              //         width: 8.0,
              //         height: 8.0,
              //         margin:
              //             const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: _currentIndex == index
              //               ? AppColor.primary
              //               : Colors.grey,
              //         ),
              //       ),
              //     );
              //   }).toList(),
              // ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 45,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadowGrey,
                        offset: Offset(0, 3),
                        blurRadius: 4,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.volume_up_rounded,
                      color: AppColor.primary,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Container(
                      height: 100,
                      alignment: Alignment.center,
                      width: 200,
                      child: Center(
                        child: CarouselSlider(
                            items:  [
                              NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Attention! Attention! To all\nPak Game members, currently'),styles: const TextStyle(
                               color: AppColor.grey1,fontWeight: FontWeight.bold
                              ) ,),

                              NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Our customer Pak \nGame members, currently'),styles: const TextStyle(
                                  color: AppColor.grey1,fontWeight: FontWeight.bold
                              ) ,),

                              NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Pak Game members, currently \nservice is....'),styles: const TextStyle(
                                  color: AppColor.grey1,fontWeight: FontWeight.bold
                              ) ,),

                            ],
                            options: CarouselOptions(
                              height: 400,
                              // aspectRatio: 16 / 9,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                              const Duration(milliseconds: 1000),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.1,
                              scrollDirection: Axis.vertical,
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Container(
                      height: 28,
                      width: 70,
                      decoration: BoxDecoration(
                          border:  Border.all(color: AppColor.primary,),
                          borderRadius: BorderRadius.circular(16)),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.local_fire_department,color: AppColor.primary,size: 18,),
                          NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Details'),styles: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                          ) ,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // ListView.builder(itemBuilder: (c,i){
              //
              // }),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3,
                        (index) {
                      Color bgColor = getColors(index);
                      return Stack(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  GamesView(catId: getCategoryModel?.data[index].id,)));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white,
                                        bgColor,
                                      ])),
                              child: Column(
                                children: [
                                  Image.network(
                                    '${getCategoryModel?.data[index].image}',
                                    height: 60,
                                    width: 80,
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('${getCategoryModel?.data[index].title}'),styles: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.white,
                                  ) ,),

                                ],
                              ),
                            ),
                          ),
                          //Image.asset('assets/images/popularback.png',scale: 2.2,),
                        ],
                      );
                    },
                  )

              ),
              const SizedBox(
                height: 10,
              ),

              Container(
                height: 95,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        3,
                            (index) => Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  GamesView(catId: getCategoryModel?.data[index+3].id,)));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    '${getCategoryModel?.data[index+3].image}',
                                    height: 40,
                                    width: 50,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 0,),
                                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate('${getCategoryModel?.data[index+3].title}'),styles: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.white,
                                  ) ,),
                                  // Text(
                                  //   "${getCategoryModel?.data[index+3].title}",
                                  //   style: const TextStyle(color: Colors.white),
                                  // ),

                                ],
                              ),
                            ),
                            const SizedBox(width: 25,),
                            index ==2?const SizedBox():
                            const VerticalDivider(
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )

                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3, (index) {
                    if(index == 1) {
                      return const SizedBox(
                        width: 16,
                      );
                    }
                    int i = index == 2?1:index;
                    Color bgColor = getColors(i+6);
                    return Flexible(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  GamesView(catId: getCategoryModel?.data[i+6].id,)));
                        },
                        child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Image.network(
                                    '${getCategoryModel?.data[i+6].image}',
                                    scale: 3.0,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    NewText(textFuture: Provider.of<LanguageProvider>(context).translate((getCategoryModel?.data[i+6].title??"").replaceAll(" ", "\n")),styles: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.white,
                                    ) ,),
                                    // Text(
                                    //   (getCategoryModel?.data[i+6].title??"").replaceAll(" ", "\n"),
                                    //   textAlign: TextAlign.end,
                                    //   style: const TextStyle(color: Colors.white),
                                    // ),
                                    const SizedBox(height: 5,)
                                  ],
                                ),
                              ],
                            )),
                      ),
                    );
                  },
                  )


              ),
              const  SizedBox(height: 10,),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 28,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                   NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Lottery'),styles: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ) ,),
                ],
              ),
              const SizedBox(
                height: 10,
              ),


              Column(
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Win Go",
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Guess the number\nGreen/Red/Purple to win",
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/wingo.png',
                          scale: 3,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "K3",
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Guess the number\nBig/Small/Odd/Even",
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/k3.png',
                          scale: 3,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "5D",
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Guess the number\nBig/Small/Odd/Even",
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/5d.png',
                          scale: 3,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Trx Win",
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Guess the number\nGreen/Red/Purple to win  ",
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/trx.png',
                          scale: 3,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 28,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                    NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Winning Information'),styles: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,

                  ) ,),

                  // Text(
                  //   "Winning Information",
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              /* Column(
              children: List.generate(3,
                      (index) => Column(
                    children: [
                      Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.shadowGrey,
                              offset: Offset(0, 2),
                              blurRadius: 2
                            )
                          ]
                        ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(children: [
                            Container(
                              height: 64,
                              width: 64,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 6,),
                            Text("Lorem Ipsum",style: TextStyle(fontSize: 12))
                          ],),
                          Row(

                            children: [
                            Container(
                              height: 64,
                              width: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey
                              ),
                            ),
                            const SizedBox(width: 6,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Receive Rs.1200",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                Text("Winning Amount",style: TextStyle(fontSize: 13,),),
                              ],
                            )
                          ],),
                        ],
                      ),

                      ),
                      const SizedBox(height: 10,),
                    ],
                  )),
            ),*/

              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: AppColor.shadowGrey,
                          offset: Offset(0, 2),
                          blurRadius: 2)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/images/mem.png",
                                fit: BoxFit.fill,
                              )),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text("Mem***FIM", style: TextStyle(fontSize: 12))
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 45,
                          width: 64,
                          decoration: BoxDecoration(
                            //shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.primary),
                          child: Image.asset(
                            "assets/images/trx.png",
                            scale: 5,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                         Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [

                                NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Receive'),styles: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,

                                ) ,),
                                const Text(
                                  " Rs170.00",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Winning Amount'),styles: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,

                            ) ,),

                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: AppColor.shadowGrey,
                          offset: Offset(0, 2),
                          blurRadius: 2)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/images/girl.png",
                                fit: BoxFit.fill,
                              )),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text("Mem***VNW", style: TextStyle(fontSize: 12))
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 45,
                          width: 64,
                          decoration: BoxDecoration(
                            //shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.primary),
                          child: Image.asset(
                            "assets/images/5d.png",
                            scale: 5,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                         Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [

                                NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Receive'),styles: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,

                                ) ,),
                                const Text(
                                  " Rs30.000",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            NewText(textFuture: Provider.of<LanguageProvider>(context).translate('Winning Amount'),styles: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,

                            ) ,),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 28,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  NewText(textFuture: Provider.of<LanguageProvider>(context).translate("Today's Earning Chart"),styles: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,

                  ) ,),

                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [

                  Image.asset('assets/images/todayaimage.png'),

                  Positioned(
                    left: 20,
                    top: -3,
                    child: Container(
                      height: 50,
                      width: 50,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/images/n2.png",
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                  Positioned(

                    left: 150,
                    top: -20,

                    child: Container(
                      height: 60,
                      width: 50,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/images/n2.png",
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                  Positioned(
                    left: 250,
                    child: Container(
                      height: 50,
                      width: 50,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/images/n2.png",
                            fit: BoxFit.fill,
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: AppColor.shadowGrey,
                          offset: Offset(0, 2),
                          blurRadius: 2)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "4",
                          style: TextStyle(color: AppColor.grey1),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/images/todaybay.png",
                                fit: BoxFit.fill,
                              )),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text("Mem***DYB", style: TextStyle(fontSize: 12))
                      ],
                    ),
                    Container(
                      height: 25,
                      width: 120,
                      decoration: BoxDecoration(
                        //shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(30),
                          color: AppColor.primary),
                      child: const Center(
                          child: Text(
                            "Rs896,379.74",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColor.white),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: AppColor.shadowGrey,
                          offset: Offset(0, 2),
                          blurRadius: 2)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "5",
                          style: TextStyle(color: AppColor.grey1),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/images/todayuncle.png",
                                fit: BoxFit.fill,
                              )),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text("Mem***AQB", style: TextStyle(fontSize: 12))
                      ],
                    ),
                    Container(
                      height: 25,
                      width: 120,
                      decoration: BoxDecoration(
                        //shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(30),
                          color: AppColor.primary),
                      child: const Center(
                          child: Text(
                            "Rs865,144.00",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColor.white),
                          )),
                    ),
                  ],
                ),
              ),


              const SizedBox(
                height: 120,
              ),
            ],
          ),
        ),
      ),
    );


  }

  GetCategoryModel? getCategoryModel;
  getCatApi() async {
    var headers = {'Cookie': 'ci_session=rliu6p075fqkj6ogvcrtorav75j548s2'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Endpoints.baseUrl}get_category'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      getCategoryModel = GetCategoryModel.fromJson(jsonDecode(result));
      print("reso]=po${getCategoryModel?.data.length}");
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }


  GetBannerModel? getBannerModel;
  getBannerApi() async {
    var headers = {'Cookie': 'ci_session=rliu6p075fqkj6ogvcrtorav75j548s2'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Endpoints.baseUrl}get_banners'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      getBannerModel = GetBannerModel.fromJson(jsonDecode(result));
      setState(() {

      });
    } else {
      print(response.reasonPhrase);
    }
  }

}
