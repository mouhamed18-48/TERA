import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/Nearreastentrepot.dart';

class NearestEntrepotDataManager {
  static Future<Nearreastentrepot?> loadStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    final EntrepotJson = prefs.getString('entrepotJson');
    if(EntrepotJson != null){
      final Map<String, dynamic> entrepotMap= json.decode(EntrepotJson);
      final Nearreastentrepot entrepot = Nearreastentrepot.fromJson(entrepotMap);
      return entrepot;
    }else{
      return null;
    }
  }
  static Future<void> saveStorageData(Nearreastentrepot entrepotJson) async{
    final prefs = await SharedPreferences.getInstance();
    String entrepot = json.encode(entrepotJson.toJson());
    await prefs.setString('entrepotJson', entrepot);
  }

  static Future<bool> hasStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('entrepotJson');
  }
  static Future<void> removeStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('entrepotJson');
  }

}