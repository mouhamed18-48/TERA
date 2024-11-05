import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/Nearreastentrepot.dart';
import '../models/nombre_produit.dart';

class NombreProduitDataManager {
  static Future<NombreProduit?> loadStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    final NombreJson = prefs.getString('nombreJson');
    if(NombreJson != null){
      final Map<String, dynamic> nombreMap= json.decode(NombreJson);
      final NombreProduit nombre = NombreProduit.fromJson(nombreMap);
      return nombre;
    }else{
      return null;
    }
  }
  static Future<void> saveStorageData(NombreProduit nombreJson) async{
    final prefs = await SharedPreferences.getInstance();
    String nombre = json.encode(nombreJson.toJson());
    await prefs.setString('nombreJson', nombre);
  }

  static Future<bool> hasStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('nombreJson');
  }
  static Future<void> removeStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('nombreJson');
  }

}