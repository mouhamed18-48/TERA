import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Produit.dart';

class ProduitDataManager {
  static Future<Produit?> loadStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    final produitJson = prefs.getString('produitJson');
    if(produitJson != null){
      final Map<String, dynamic> ProduitMap= json.decode(produitJson);
      final Produit produit = Produit.fromJson(ProduitMap);
      return produit;
    }else{
      return null;
    }
  }
  static Future<void> saveStorageData(Produit produitJson) async{
    final prefs = await SharedPreferences.getInstance();
    String produit = json.encode(produitJson.toJson());
    await prefs.setString('storeJson', produit);
  }

  static Future<bool> hasStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('produit');
  }
  static Future<void> removeStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('produitJson');
  }

}