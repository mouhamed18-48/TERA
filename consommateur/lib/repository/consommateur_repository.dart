import 'dart:convert';
import 'package:consommateur/models/ProduitDispo.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/Entrepot.dart';
import '../models/Vente.dart';
import '../models/Ventes.dart';
import '../models/consommateur.dart';
import '../shared_preferences/consommateur_data_manager.dart';



class ConsommateurRepository{
  final String serverUrl = "http://192.168.202.139:4040/tera/consommateur";



  Future<bool> registerConsommateur({required Consommateur consommateur}) async{
    final response=await http.post(Uri.parse("$serverUrl/registerConsommateur"), headers: {
      "Content-Type": "application/json",

    },
        body: jsonEncode({
          "consommateurFirstName": consommateur.consommateurfirstname,
          "consommateurSecondName": consommateur.consommateursecondname,
          "consommateurPhone": consommateur.consommateurphone,
          "consommateurPassword": consommateur.consommateurpassword
        })
    );

    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }

  Future<Consommateur?> loginconsommateur({required String phone, required String password}) async{
    final response = await http.post(Uri.parse("$serverUrl/loginConsommateur"),
      headers:{"Content-Type" : "application/json"},
      body: jsonEncode({
        'consommateurPhone':phone,
        'consommateurPassword':password
      }),
    );
    if(response.statusCode == 200){
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      final consommateur = Consommateur.fromJson(responseData['consommateur']);
      await ConsommateurDataManager.saveStorageData(consommateur);
      return consommateur;
    }else if(response.statusCode == 401){
      return null;
    }else{
      throw Exception('Failed to logg');
    }
  }
  Future<List<EntrepotClass>?> getAllEntrepot() async{
    final response=await http.post(Uri.parse("$serverUrl/getEntrepot"));

    if(response.statusCode==200){
      final List<dynamic> data = json.decode(response.body)['entrepots'];
      return data.map((json) => EntrepotClass.fromJson(json)).toList();
    }
    else if(response.statusCode==500) {
      return null;
    }else{
      Get.snackbar('Entrepot', "Il n'y pas d'entrpot disponible");
    }
  }
  Future<List<String>?> getDistinctProductTypes(String? entrepotId) async {
    final url = Uri.parse('$serverUrl/getDistinctProductTypes'); // Assurez-vous que cette URL est correcte


    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'entrepotId': entrepotId}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<String> productTypes = List<String>.from(
          data['productTypes'].map((item) => item['produit_type']));
      return productTypes;
    } else{
      null;
    }
  }

  Future<List<ProduitDispo>?> getProduit() async{
    final response=await http.post(Uri.parse("$serverUrl/getProduitsDispo"));

    if(response.statusCode==200){
      final List<dynamic> data = json.decode(response.body)['products'];
      return data.map((json) => ProduitDispo.fromJson(json)).toList();
    }
    else if(response.statusCode==404) {
      return [];
    }else{
      Get.snackbar('Entrepot', "Il n'y pas d'entrpot disponible");
    }
  }


  Future<List<ProduitDispo>?> getProduitEntrepot(String? id) async{
    final response=await http.post(
        Uri.parse("$serverUrl/getProduitsDispoEntrepot"),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({'id': id})
    );

    if(response.statusCode==200){
      final List<dynamic> data = json.decode(response.body)['products'];
      return data.map((json) => ProduitDispo.fromJson(json)).toList();
    }
    else if(response.statusCode==404) {
      return [];
    }else{
      Get.snackbar('Entrepot', "Il n'y pas de produits disponible");
    }
  }

  Future<List<Ventes>?> getVenteEncour(String? phone) async{
    final response=await http.post(
        Uri.parse("$serverUrl/getVenteEncour"),
        headers: {'Content-Type':'application/json'},
        body: jsonEncode({'phone': phone})
    );

    if(response.statusCode==200){
      final List<dynamic> data = json.decode(response.body)['ventes'];
      return data.map((json) => Ventes.fromJson(json)).toList();
    }
    else if(response.statusCode==404) {
      return [];
    }else{
      print('Pas de vente en cour');
    }
  }

  Future<List<Ventes>?> getVentePasEncour(String? phone) async{
    final response=await http.post(
        Uri.parse("$serverUrl/getVentePasEncour"),
        headers: {'Content-Type':'application/json'},
        body: jsonEncode({'phone': phone})
    );

    if(response.statusCode==200){
      final List<dynamic> data = json.decode(response.body)['ventes'];
      return data.map((json) => Ventes.fromJson(json)).toList();
    }
    else if(response.statusCode==404) {
      return [];
    }else{
      print('Pas de vente en cour');
    }
  }


  Future<bool> createVente(Vente vente) async {
    final url = Uri.parse('$serverUrl/createVente');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(vente.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ProduitDispo>?> getProduitsInfo() async {
    final response = await http.post(
      Uri.parse("$serverUrl/getProduitsInfo"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProduitDispo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  }