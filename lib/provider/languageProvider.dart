import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class LanguageProvider extends ChangeNotifier {
  final GoogleTranslator _translator = GoogleTranslator();
  String _selectedLanguage = 'en'; // Default language is English

  String get selectedLanguage => _selectedLanguage;

  Future<String?> languageFromPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString("selectedLanguage");
    return language;
  }


  Future <void> setLanguage(String languageCode) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    _selectedLanguage = languageCode;
    notifyListeners();
  }

   Future<String> translate(String text) async {
    if(_selectedLanguage == 'en'){
     String? language =  await languageFromPrefs();
     _selectedLanguage = language??_selectedLanguage;
      Translation translation =
      await _translator.translate(text, to: _selectedLanguage);
      return translation.text;
    }else {
      Translation translation =
          await _translator.translate(text, to: _selectedLanguage);
      return translation.text;
    }
  }



}
 