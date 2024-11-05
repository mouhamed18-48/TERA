import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:producteur/constant.dart';
import '../models/EntrepotProduit.dart';
import '../models/Produit.dart';
import '../models/ProduitQuantiteProducter.dart';
import '../models/nombre_produit.dart';
class ProduitRepository{


  final String serverUrl = "http://${ipAdress}:3003/tera/produit";

  Future<List<String>?> getEntrepotProduit( String? entrepotId) async{
    final response=await http.post(Uri.parse("$serverUrl/getProduitEntrepots"), headers: {
    "Content-Type": "application/json",

    },
        body: jsonEncode({
          "entrepotId": entrepotId
        })
    );

    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      final List<String> productTypes = List<String>.from(
          data['produits'].map((item) => item['produit_type']));
      return productTypes;

    }
    else if(response.statusCode==500) {
      return null;
    }else{
      Get.snackbar('Entrepot', "Il n'y pas de produits pour cette entrepot");
    }
  }

  Future<Produit?> getProduitInfos({required EntrepotProduit entrepotproduit}) async{
    final response=await http.post(Uri.parse("$serverUrl/getProduitInfos")
        , headers: {
          "Content-Type": "application/json",

        },
        body: jsonEncode({
          "produitType": entrepotproduit.produittype
        })
    );

    if(response.statusCode==200){
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final produit = Produit.fromJson(responseData['produit']);
      return produit;
    }
    if(response.statusCode==500) {
      return null;
    }
  }



  Future<List<Produit>?> getProduits() async {
    final response = await http.post(
      Uri.parse("$serverUrl/getProduits"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Produit.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }


  Future<NombreProduit> getNumberProduits(String? resProducteur, String? entrepotName) async {
    final response = await http.post(
      Uri.parse("$serverUrl/getNumberProduits"),
      headers: {
        'Content-Type': 'application/json',
      },
        body: jsonEncode({
          "producterPhone": resProducteur,
          "entrepotName": entrepotName
        })
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return NombreProduit.fromJson(responseData['nombreProduits']);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Pour récupérer l'ensemble des produits en réservation pour un producteur et sommer les quantités pour chaque produit

  Future<List<ProduitQuantiteProducteur>?> getProductsWithQuantities(String? producerPhone) async {
    final url = Uri.parse('$serverUrl/getProductsWithQuantities'); // Remplacez par l'URL correcte


    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'producterPhone': producerPhone}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['products'];
      return data.map((json) => ProduitQuantiteProducteur.fromJson(json)).toList();
    } else if (response.statusCode == 404){
      return [];
    }else {
      throw Exception('Failed to load products: ${response.body}');
    }
  }


}