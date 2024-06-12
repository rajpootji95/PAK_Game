import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pak_games/Utils/colors.dart';
import 'package:pak_games/provider/cartProvider.dart';
import 'package:pak_games/provider/languageProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Splash/SplashScreen.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  Future.delayed(Duration(seconds: 1),(){
    language();
  });

}
language() async {
  String? selectedLanguage;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  selectedLanguage = prefs.getString('selectedLanguage');
 print("this language--->${selectedLanguage}");
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> CartProvider()),
        ChangeNotifierProvider(create: (_)=> LanguageProvider()),
      ],
      child: MaterialApp(
        title: 'PAK Games',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent
          ),
          useMaterial3: true,
        ),
        home: SplashScreen(),
       // MyHomePage(title: ' PAK\n =Games='),
      ),
    );
  }
}



/*import 'package:binance_pay/binance_pay.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text(
            //   'Cup Cake  \$ 1.0',
            // ),
            TextButton(
                onPressed: () {
                  makePayment();
                },
                child: const Text('Buy Now')),
          ],
        ),
      ),
    );
  }

  makePayment() async {
    BinancePay pay = BinancePay(
      apiKey:"oueD0sEAMMNCDfRcjwO0UI30OuRAhw6MBy3dLCTe2Il2dnJyQuNdmnZGaAF9vKA0",
      apiSecretKey:"W5ORTL4UyXCjYvqTzYw1Ga95bRu4XR6NOWhZf9bI7aLBX9De4HqPQxJlt6q7d9nJ",
    );

    String tradeNo = generateMerchantTradeNo();

    OrderResponse response;
    try {
      response = await pay.createOrder(
        body: RequestBody(
          merchantTradeNo: tradeNo,
          terminalType: "APP",
          orderAmount: '1.01',
          currency: 'USDT',
          goodsType: '01',
          goodsCategory: '1000',
          referenceGoodsId: 'referenceGoodsId',
          goodsName: 'goodsName',
          goodsDetail: 'goodsDetail',
        ),
      );
      // Log the entire response for debugging
      //debugPrint("CreateOrder response: ${response.toJson()}");
    } catch (e) {
      debugPrint("Order creation failed: $e");
      return;
    }
    debugPrint("Order response: ${response.errorMessage}");
    if (response.data == null) {
      debugPrint("Failed to create order. No data returned.");
      return;
    }
    /// Query the order
    QueryResponse queryResponse;
    try {
      queryResponse = await pay.queryOrder(
        merchantTradeNo: tradeNo,
        prepayId: response.data?.prepayId ?? "1",
      );
      // Log the entire response for debugging
      //debugPrint("QueryOrder response: ${queryResponse.toJson()}");

    } catch (e) {
      debugPrint("Order query failed: $e");
      return;
    }
    CloseResponse closeResponse;
    try {
      closeResponse = await pay.closeOrder(
        merchantTradeNo: tradeNo,
      );

      // Log the entire response for debugging
      //debugPrint("CloseOrder response: ${closeResponse.toJson()}");

    } catch (e) {
      debugPrint("Order closing failed: $e");
      return;
    }
    debugPrint(closeResponse.status);
  }

// String generateMerchantTradeNo() {
  //   // Generate a unique trade number (implement as per your requirement)
  //   return DateTime.now().millisecondsSinceEpoch.toString();
  // }
}*/




