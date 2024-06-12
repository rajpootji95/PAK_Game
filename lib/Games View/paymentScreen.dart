//
// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
//
// import '../Utils/colors.dart';
// import 'Thankyou.dart';
// import 'new-pay.dart';
//
// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});
//
//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   TextEditingController amountController = TextEditingController();
//
//   int amount = 0;
//   int total = 0;
//
//   calCulateTotal() {
//     setState(() {
//       total = amount + 20;
//     });
//   }
//
//   Map<String, dynamic>? paymentIntentData;
//
//   Future<void> initPaymentSheet() async {
//     try {
//       // 1. create payment intent on the client side by calling stripe api
//       final data = await createPaymentIntent(
//           // convert string to double
//           amount: (int.parse(total.toString()) * 100).toString(),
//           currency: "USD",
//           name: "",
//           address: "",
//           pin: "",
//           city: "",
//           state: "",
//           country: 'USA');
//
//       // 2. initialize the payment sheet
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           customFlow: false,
//           merchantDisplayName: 'Test Merchant',
//           paymentIntentClientSecret: data['client_secret'],
//           customerEphemeralKeySecret: data['ephemeralKey'],
//           customerId: data['id'],
//           style: ThemeMode.system,
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//       rethrow;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.primary,
//       appBar: AppBar(
//         backgroundColor: AppColor.primary,
//         automaticallyImplyLeading: false,
//         centerTitle: false,
//         title: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: const Row(
//                 children: [
//                   Icon(
//                     Icons.arrow_back_ios,
//                     color: Colors.black,
//                     size: 20,
//                   ),
//                   Text(
//                     "Back",
//                     style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black),
//                   ),
//                 ],
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(right: 10),
//               child: Text(
//                 "Payment",
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w900,
//                     color: AppColor.grey1),
//               ),
//             ),
//             Container(
//               width: 50,
//             )
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Enter amount",
//                     style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: AppColor.primary),
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     "(\$)",
//                     style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: AppColor.grey1),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 6,
//               ),
//               TextFormField(
//                 controller: amountController,
//                 keyboardType: TextInputType.number,
//                 onChanged: (v) {
//                   setState(() {
//                     amount = int.parse(v.toString());
//                     calCulateTotal();
//                   });
//                 },
//                 decoration: InputDecoration(
//                     counterText: "",
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//                     hintText: "Enter amount in \$ ",
//                     hintStyle: const TextStyle(fontSize: 13),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide:
//                             const BorderSide(color: Colors.transparent)),
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide:
//                             const BorderSide(color: Colors.transparent)),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide:
//                             const BorderSide(color: Colors.transparent)),
//                     filled: true,
//                     fillColor: Colors.white),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Fill up",
//                     style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black),
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     "@ \$7.50 per gallon",
//                     style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: AppColor.grey1),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Column(
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Description",
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: AppColor.grey1),
//                         ),
//                         Text(
//                           "Amount",
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: AppColor.grey1),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const DottedLine(
//                       direction: Axis.horizontal,
//                       alignment: WrapAlignment.center,
//                       lineLength: double.infinity,
//                       lineThickness: 2.0,
//                       dashLength: 4.0,
//                       dashColor: Color(0xffE2E2E2),
//                       dashRadius: 0.0,
//                       dashGapLength: 5.0,
//                       dashGapColor: Colors.transparent,
//                       dashGapRadius: 0.0,
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Fuel Amount",
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xff888888)),
//                         ),
//                         Text(
//                           "\$ ${amount}",
//                           style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xff888888)),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Shipping",
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xff888888)),
//                         ),
//                         Text(
//                           amount == 0 ? "0.00" : "\$20.00",
//                           style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xff888888)),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const DottedLine(
//                       direction: Axis.horizontal,
//                       alignment: WrapAlignment.center,
//                       lineLength: double.infinity,
//                       lineThickness: 2.0,
//                       dashLength: 4.0,
//                       dashColor: Color(0xffE2E2E2),
//                       dashRadius: 0.0,
//                       dashGapLength: 5.0,
//                       dashGapColor: Colors.transparent,
//                       dashGapRadius: 0.0,
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Total",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black),
//                         ),
//                         Text(
//                           "\$${total}",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700,
//                               color: AppColor.grey1),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               MaterialButton(
//                 height: 50,
//                 minWidth: MediaQuery.of(context).size.width,
//                 color: AppColor.grey1,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//                 onPressed: () async {
//                   await initPaymentSheet();
//
//                   try {
//                     await Stripe.instance.presentPaymentSheet();
//
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                       content: Text(
//                         "Payment Done",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       backgroundColor: Colors.green,
//                     ));
//
//                     setState(() {});
//                     Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (context) => const ThankScreen()),
//                         (route) => false);
//                   } catch (e) {
//                     print("payment sheet failed");
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                       content: Text(
//                         "Payment Failed",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       backgroundColor: Colors.redAccent,
//                     ));
//                   }
//                   //  initPaymentSheet();
//
//                   // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ThankScreen()), (route) => false);
//                 },
//                 child: const Text(
//                   "Pay",
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w800,
//                       color: Colors.white),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
