import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:producteur/constant.dart';
import 'package:producteur/models/Nearreastentrepot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/Entrepot.dart';

class EntrepotRepository {
  final String serverUrl = "http://${ipAdress}:3002/tera/entrepot";

  Future<List<Entrepot>?> getAllEntrepot() async {
    final response = await http.post(Uri.parse("$serverUrl/getAllEntrepot"));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['entrepots'];
      return data.map((json) => Entrepot.fromJson(json)).toList();
    } else if (response.statusCode == 500) {
      return null;
    } else {
      Get.snackbar('Entrepot', "Il n'y pas d'entrpot disponible");
    }
    return null;
  }

  Future<void> openMap(double? latitude, double? longitude) async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    final Uri googleUri = Uri.parse(googleUrl);

    if (await canLaunchUrl(googleUri)) {
      await launchUrl(googleUri);
    } else {
      throw 'Could not open the map.';
    }
  }

  Future<Nearreastentrepot> getNearestEntrepot(
      double userLatitude, double userLongitude, String? producterPhone) async {
    final response = await http.post(
      Uri.parse("$serverUrl/getNearestEntrepot"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'userLatitude': userLatitude,
        'userLongitude': userLongitude,
        'producterPhone': producterPhone.toString(),
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return Nearreastentrepot.fromJson(responseData['entrepot']);
    } else {
      throw Exception('Failed to load nearest entrepot');
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
}
