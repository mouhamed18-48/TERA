import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/Producteur.dart';

class ProducteurDataManager {
  static Future<Producteur?>? loadStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    final ProducteurJson = prefs.getString('producteurJson');
    if(ProducteurJson != null){
      final Map<String, dynamic> producteurMap= json.decode(ProducteurJson);
      final Producteur producter = Producteur.fromJson(producteurMap);
      return producter;
    }else{
      return null;
    }
  }
  static Future<void> saveStorageData(Producteur producterJson) async{
    final prefs = await SharedPreferences.getInstance();
    String producter = json.encode(producterJson.toJson());
    await prefs.setString('producteurJson', producter);
  }

  static Future<bool> hasStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('producteurJson');
  }
  static Future<void> removeStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('producteurJson');
  }

}