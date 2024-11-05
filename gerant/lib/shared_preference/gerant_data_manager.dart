import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/Gerant.dart';

class GerantDataManager {
  static Future<Gerant?>? loadStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    final GerantJson = prefs.getString('gerantJson');
    if(GerantJson != null){
      final Map<String, dynamic> gerantMap= json.decode(GerantJson);
      final Gerant gerant = Gerant.fromJson(gerantMap);
      return gerant;
    }else{
      return null;
    }
  }
  static Future<void> saveStorageData(Gerant gerantJson) async{
    final prefs = await SharedPreferences.getInstance();
    String gerant = json.encode(gerantJson.toJson());
    await prefs.setString('gerantJson', gerant);
  }

  static Future<bool> hasStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('gerantJson');
  }
  static Future<void> removeStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('gerantJson');
  }

}