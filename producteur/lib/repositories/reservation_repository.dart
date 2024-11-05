import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:producteur/constant.dart';

import '../models/EntrepotQuantiteAndProduitForProducteur.dart';
import '../models/QuantitiesByEntrepot.dart';
import '../models/RegisterReservation.dart';
import '../models/Reservation.dart';
import '../models/ReservedProductsEntrepot.dart';
import '../models/produitByEntrepot.dart';

class ReservationReposity{

  final String serverUrl = "http://${ipAdress}:3001/tera/reservations";
  final String serverUrl1 = "http://${ipAdress}:3003/tera/produit";
  final String serverUrl2 = "http://${ipAdress}:3002/tera/entrepot";



  // Créer une réservation
  Future<bool> createReservation(RegisterReservation reservation) async {
    final url = Uri.parse('$serverUrl1/registerReservation');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reservation.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  //récupère la quantité totale de réservations pour un producteur donné et un produit spécifique, regroupée par entrepôt. Elle renvoie également l'identifiant et le nom de chaque entrepôt.




  //récupérer les types de produits distincts pour un producteur donné.
  Future<List<String>?> getDistinctProductTypes(String? producerPhone) async {
    final url = Uri.parse('$serverUrl1/getDistinctProductTypes'); // Assurez-vous que cette URL est correcte


      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'resProducter': producerPhone}),
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







// Pour récupérer la quantité de produit réservée dans chaque entrepôt pour un producteur donné et un produit spécifique,

  Future<List<QuantitiesByEntrepot>?> getQuantitiesByEntrepot(String? producterPhone, String? produitType) async {
    final url = Uri.parse('$serverUrl1/getQuantitiesByEntrepot'); // Remplacez par l'URL correcte


      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'producterPhone': producterPhone, 'produitType': produitType}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['quantities'];
        return data.map((json) => QuantitiesByEntrepot.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load quantities: ${response.body}');
      }
  }

//Pour récupérer l'ensemble des produits qu'un producteur a en réserve dans un entrepôt donné ainsi que les quantités de chaque produit

  Future<List<Reservedproductsentrepot>?> getReservedProductsEntrepot(String? producterPhone, String? entrepotId) async {
    final url = Uri.parse('$serverUrl2/getReservedProductsEntrepot'); // Remplacez par l'URL correcte


      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'resProducteur': producterPhone, 'resEntrepot': entrepotId}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['products'];
        return data.map((json) => Reservedproductsentrepot.fromJson(json)).toList();
      } else if(response.statusCode == 404){
        return [];
      }else {
        throw Exception('Failed to load reserved products: ${response.body}');
      }
  }




  //Pour récupérer les entrepôts où un producteur a fait des réservations, le nombre distinct de produits dans chaque entrepôt, ainsi que la quantité globale de ces produits,

  Future<List<produitByEntrepot>?> getProductDetailsByEntrepot(String? producterPhone) async {
    final url = Uri.parse('$serverUrl2/getProductDetailsByEntrepot');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'producterPhone': producterPhone}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['productDetails'];
        return data.map((json) => produitByEntrepot.fromJson(json)).toList();
      } else if(response.statusCode == 404){
        return [];
      }else {
        throw Exception('Failed to load product details: ${response.body}');
      }
  }

//Pour récupérer le nom de l'entrepôt, la quantité, et le type de produit pour chaque réservation en cours d'un producteur donné,
  Future<List<EntrepotQuantiteAndProduitForProducteur>?> getEntrepotQuantiteAndProduitForProducteur(String? producterPhone) async {
    final url = Uri.parse('$serverUrl2/getEntrepotQuantiteAndProduitForProducteur');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'producterPhone': producterPhone,
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['reservations'];
      return data.map((json) => EntrepotQuantiteAndProduitForProducteur.fromJson(json)).toList();
      } else if(response.statusCode == 404) {
      return [];
    }else{
      throw Exception('Failed to load reservations');
    }
  }


  // Pour récupérer la quantité qu'un utilisateur a réservée aujourd'hui pour un produit spécifique, et renvoyer la valeur zéro s'il n'a pas effectué de réservation,



}