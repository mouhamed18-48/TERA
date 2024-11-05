import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:producteur/constant.dart';

class ProduitProductionRepository{
  final String serverUrl = "http://${ipAdress}:3003/tera/produit";

  Future<bool> registerProducts(String? producterPhone, List<String> produits) async {

    final response = await http.post(
      Uri.parse("$serverUrl/createProduitProducteur"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'producterPhone': producterPhone,
        'produits': produits,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}
