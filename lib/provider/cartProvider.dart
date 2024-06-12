// Define a class for the cart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/userModel.dart';

class CartProvider extends ChangeNotifier {
  final List<String> _items = [];

  List<String> get items => _items;


  void addItem(String item) {
    _items.add(item);
    print("added now ${item}");

    notifyListeners();
  }

  UserModel userModel = UserModel();

  getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var headers = {
      'Content-Type': 'application/json',
      'X-Shopify-Storefront-Access-Token': '7645a469dcb8f5702f790cf015530730'
    };
    var request =
        http.Request('POST', Uri.parse('${dotenv.env['SHOPIFY_URL']}'));
    request.body =
        '''{"query":"query FetchCustomerInfo(\$customerAccessToken: String!) {\\n  customer(customerAccessToken: \$customerAccessToken) {\\n    email\\n    firstName\\n    id\\n    lastName\\n    defaultAddress {\\n        id\\n    }\\n    addresses(first: 100) {\\n        edges {\\n            node {\\n                address1\\n                city\\n                country\\n                id\\n                province\\n                zip\\n            }\\n        }\\n    }\\n  }\\n}","variables":{"customerAccessToken":"${token}"}}''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = UserModel.fromJson(json.decode(finalResult));

      userModel = jsonResponse;


    } else {
      print(response.reasonPhrase);
    }
  }

  void removeItem(String index) {
    _items.remove(index);
  

    notifyListeners();
  }

  void clearCart() {
    _items.clear(); // Clear all items from the cart

    notifyListeners();
  }

  int get itemCount => _items.length;

  List<String> getAllItems() {
    return List<String>.from(_items);
  }

  int _cartLength = 0;

  int get cartLength => _cartLength;




}
