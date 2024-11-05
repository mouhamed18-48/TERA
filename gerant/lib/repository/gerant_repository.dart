import 'dart:convert';

import 'package:gerant/models/reservationProd.dart';
import 'package:http/http.dart' as http;

import '../models/EntrepotCapacityByName.dart';
import '../models/EntrepotLivraison.dart';
import '../models/Gerant.dart';
import '../models/NumberReservationExpiredIn7Day.dart';
import '../models/ProducerReservation.dart';
import '../models/Produit.dart';
import '../models/ProduitEntrepot.dart';
import '../models/ProduitProducer.dart';
import '../models/Produteur.dart';
import '../models/Reservation.dart';
import '../models/updateStock.dart';
import '../shared_preference/gerant_data_manager.dart';

class GerantRepository {
  final String serverUrl = "http://192.168.202.64:3030/tera/gerant";

  Future<Gerant?> loginGerant(
      {required String id, required String password}) async {
    final response = await http.post(
      Uri.parse("$serverUrl/loginGerant"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'gerantId': id, 'gerantPassword': password}),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final gerant = Gerant.fromJson(responseData['gerant']);
      await GerantDataManager.saveStorageData(gerant);
      print(gerant);
      return gerant;
    } else if (response.statusCode == 401) {
      print(response.statusCode);
      return null;
    } else {
      throw Exception('Failed to logg');
    }
  }

  Future<Entrepotcapacitybyname> getEntrepotCapacityByName(
      String? entrepotName) async {
    final response =
        await http.post(Uri.parse("$serverUrl/getEntrepotCapacityByName"),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({"entrepotName": entrepotName}));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return Entrepotcapacitybyname.fromJson(responseData['capacity']);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Numberreservationexpiredin7day> getNumberReservationExpiredIn7Day(
      String? entrepotName) async {
    final response = await http.post(
        Uri.parse("$serverUrl/getNumberReservationExpiredIn7Day"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"entrepotName": entrepotName}));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return Numberreservationexpiredin7day.fromJson(responseData['number']);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<String> getEntrepotIdByName(String? entrepotName) async {
    final response = await http.post(
      Uri.parse("$serverUrl/getEntrepotIdByName"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'entrepotName': entrepotName,
      }),
    );

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body)['entrepot_id'];
      return data.toString();
    } else {
      throw Exception('Failed to load nearest entrepot');
    }
  }

  //récupérer les types de produits distincts pour un producteur donné.
  Future<List<String>?> getDistinctProductTypes(String? entrepotName) async {
    final url = Uri.parse(
        '$serverUrl/getDistinctProductTypes'); // Assurez-vous que cette URL est correcte

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'entrepotName': entrepotName}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<String> productTypes = List<String>.from(
          data['productTypes'].map((item) => item['produit_type']));
      return productTypes;
    } else {
      null;
    }
    return null;
  }

  Future<List<Produit>?> getProduits() async {
    final response = await http.post(
      Uri.parse("$serverUrl/getProduits"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['produits'];
      return data.map((json) => Produit.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Entrepotlivraison>?> getEntrepotLivraison(
      String? entrepotName) async {
    final url = Uri.parse(
        '$serverUrl/getEntrepotLivraison'); // Remplacez par l'URL correcte

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'entrepotName': entrepotName}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['Livraisons'];
      return data.map((json) => Entrepotlivraison.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Livraisons: ${response.body}');
    }
  }

  Future<List<Entrepotlivraison>?> getDemandeEntrepotLivraison(
      String? entrepotName) async {
    final url = Uri.parse(
        '$serverUrl/getDemandeEntrepotLivraison'); // Remplacez par l'URL correcte

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'entrepotName': entrepotName}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['Livraisons'];
      return data.map((json) => Entrepotlivraison.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Livraisons: ${response.body}');
    }
  }

  Future<List<Entrepotlivraison>?> getEntrepotReservationDeposer(
      String? entrepotName) async {
    final url = Uri.parse(
        '$serverUrl/getEntrepotReservationDeposer'); // Remplacez par l'URL correcte

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'entrepotName': entrepotName}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['Livraisons'];
      return data.map((json) => Entrepotlivraison.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Livraisons: ${response.body}');
    }
  }

  Future<List<reservationProd>?> getEntrepotReservationProducteurEnCour(
      String? entrepotName, String? resProducteur) async {
    final url = Uri.parse(
        '$serverUrl/getEntrepotReservationProducteurEnCour'); // Remplacez par l'URL correcte

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'entrepotName': entrepotName, 'resProducteur': resProducteur}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['Livraisons'];
      return data.map((json) => reservationProd.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Livraisons: ${response.body}');
    }
  }

  Future<List<Entrepotlivraison>?> getEntrepotReservationExpiringToday(
      String? entrepotName) async {
    final url = Uri.parse(
        '$serverUrl/getEntrepotReservationExpiringToday'); // Remplacez par l'URL correcte

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'entrepotName': entrepotName}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['Livraisons'];
      return data.map((json) => Entrepotlivraison.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Livraisons: ${response.body}');
    }
  }

  Future<List<Producteur>?> getDistinctProducteur(String? entrepotName) async {
    final url = Uri.parse(
        '$serverUrl/getDistinctProducteur'); // Remplacez par l'URL correcte

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'entrepotName': entrepotName}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['Producteurs'];
      return data.map((json) => Producteur.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Livraisons: ${response.body}');
    }
  }

  Future<List<ProduitProducer>?> getProduitProducer(
      String? entrepotName, String? producerPhone) async {
    final url = Uri.parse(
        '$serverUrl/getProduitProducer'); // Remplacez par l'URL correcte

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'entrepotName': entrepotName, 'producerPhone': producerPhone}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['Produits'];
      return data.map((json) => ProduitProducer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Livraisons: ${response.body}');
    }
  }

  Future<List<ProduitEntrepot>?> getProduitEntrepot(
      String? entrepotName) async {
    final url = Uri.parse(
        '$serverUrl/getProduitEntrepot'); // Remplacez par l'URL correcte

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'entrepotName': entrepotName}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['Produits'];
      return data.map((json) => ProduitEntrepot.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Livraisons: ${response.body}');
    }
  }

  Future<List<Producerreservation>?> getNumberProducteurReservation(
      String? entrepotName) async {
    final url = Uri.parse(
        '$serverUrl/getNumberProducteurReservation'); // Remplacez par l'URL correcte

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'entrepotName': entrepotName}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data =
          json.decode(response.body)['NumberReservation'];
      return data.map((json) => Producerreservation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Number: ${response.body}');
    }
  }

  Future<bool> updateReservationLivrer(
      String? reservationId, int? nouvelleValeur) async {
    final url = Uri.parse(
        '$serverUrl/updateReservationLivrer'); // Remplacez par l'URL correcte

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'reservationId': reservationId, 'nouvelleValeur': nouvelleValeur}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateReservationEncours(
      String? reservationId, int? nouvelleValeur) async {
    final url = Uri.parse(
        '$serverUrl/updateReservationEncours'); // Remplacez par l'URL correcte

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'reservationId': reservationId, 'nouvelleValeur': nouvelleValeur}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> ajoutStock(Reservation reservation) async {
    final url = Uri.parse('$serverUrl/ajoutStock');
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
  Future<bool> ModifStock(Update update) async {
    final url = Uri.parse('$serverUrl/ModificationStock');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(update.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
