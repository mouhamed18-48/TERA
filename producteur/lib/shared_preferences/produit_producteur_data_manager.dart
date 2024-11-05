import 'package:shared_preferences/shared_preferences.dart';

class ProduitProducteurDataManager {
  static Future<List<String>?> loadStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    final produit = prefs.getStringList('produit');
    if(produit != null){
      return produit;
    }else{
      return null;
    }
  }
  static Future<void> saveStorageData(List<String> produit) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('produit', produit);
  }

  static Future<bool> hasStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('produit');
  }
  static Future<void> removeStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('produit');
  }

}