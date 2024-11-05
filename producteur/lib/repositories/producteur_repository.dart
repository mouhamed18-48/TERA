import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:producteur/constant.dart';
import '../models/Producteur.dart';
import '../shared_preferences/producteur_data_manager.dart';



class ProducteurRepository{
  final String serverUrl = "http://${ipAdress}:3001/tera/producteur";




  Future<bool> registerProducteur({required Producteur producteur}) async{
    final response=await http.post(Uri.parse("$serverUrl/registerProducteur"), headers: {
      "Content-Type": "application/json",

    },
      body: jsonEncode({
        "producterFirstName": producteur.producterfirstname,
        "producterSecondName": producteur.productersecondname,
        "producterPhone": producteur.producterphone,
        "producterPassword": producteur.producterpassword
      })
    );

    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }

  Future<Producteur?> loginProducter({required String phone, required String password}) async{
    final response = await http.post(Uri.parse("$serverUrl/loginProducteur"),
      headers:{"Content-Type" : "application/json"},
      body: jsonEncode({
        'producterPhone':phone,
        'producterPassword':password
      }),
    );
    if(response.statusCode == 200){
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final producteur = Producteur.fromJson(responseData['producter']);
      await ProducteurDataManager.saveStorageData(producteur);

      return producteur;
    }else if(response.statusCode == 401){
      return null;
    }else{
      throw Exception('Failed to logg');
    }
  }

}