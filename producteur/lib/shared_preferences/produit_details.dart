import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ProduitName.dart';

class ProduitDetailsDataManager {
  static Future<ProduitName?> loadStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    final produitJson = prefs.getString('produitJson');
    if(produitJson != null){
      final Map<String, dynamic> ProduitMap= json.decode(produitJson);
      final ProduitName produit = ProduitName.fromJson(ProduitMap);
      return produit;
    }else{
      return null;
    }
  }
  static Future<void> saveStorageData(ProduitName produitName) async{
    final prefs = await SharedPreferences.getInstance();
    String produit = json.encode(produitName.toJson());
    await prefs.setString('produitJson', produit);
  }

  static Future<bool> hasStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('produitJson');
  }
  static Future<void> removeStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('produitJson');
  }

}