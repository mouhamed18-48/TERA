import 'dart:convert';

import 'package:consommateur/models/consommateur.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsommateurDataManager {
  static Future<Consommateur?>? loadStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    final ConsommateurJson = prefs.getString('consommateurJson');
    if(ConsommateurJson != null){
      final Map<String, dynamic> consommateurMap= json.decode(ConsommateurJson);
      final Consommateur consommateur = Consommateur.fromJson(consommateurMap);
      return consommateur;
    }else{
      return null;
    }
  }
  static Future<void> saveStorageData(Consommateur consommateurJson) async{
    final prefs = await SharedPreferences.getInstance();
    String consommateur = json.encode(consommateurJson.toJson());
    await prefs.setString('consommateurJson', consommateur);
  }

  static Future<bool> hasStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('consommateurJson');
  }
  static Future<void> removeStoreData() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('consommateurJson');
  }

}