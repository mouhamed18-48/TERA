import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:producteur/constant.dart';

class ProductionRepository {
  final String serverUrl = "http://${ipAdress}:3003/tera/produit";

  Future<void> registerProduction(
      int nombreChamps, String adresse, String? producteurPhone) async {
    final response = await http.post(
      Uri.parse("$serverUrl/registerProduction"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'nombreChamps': nombreChamps,
        'adresse': adresse,
        'producteurPhone': producteurPhone,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('Success: ${responseData['message']}');
    } else {
      final responseData = json.decode(response.body);
      print('Error: ${responseData['message']}');
    }
  }

  Future<bool> checkProductionExists(String? producteurPhone) async {
    final response = await http.post(
      Uri.parse("$serverUrl/checkProductionExists"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"producteurPhone": producteurPhone}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['exists'];
    } else {
      throw Exception('Erreur lors de la vérification de la production');
    }
  }
}
