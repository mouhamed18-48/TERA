import 'package:flutter/material.dart';
import 'package:consommateur/constant.dart';

class ProducteursEntrepot extends StatelessWidget {
  const ProducteursEntrepot({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Producteurs", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Producteur(name: "Ibrahima Dia"),
              Producteur(name: "Ibrahima Dia"),
              Producteur(name: "Ibrahima Dia"),
              Producteur(name: "Ibrahima Dia"),
              Producteur(name: "Ibrahima Dia"),
              Producteur(name: "Ibrahima Dia"),
              Producteur(name: "Ibrahima Dia"),
              Producteur(name: "Ibrahima Dia"),
              Producteur(name: "Ibrahima Dia"),
              Producteur(name: "Ibrahima Dia"),
            ],
          ),
        ),
      ],
    );
  }
}

class Producteur extends StatelessWidget {
  final String name;
  const Producteur({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: teraGrey,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Image.asset("assets/icons/icons8-utilisateur-sexe-neutre-90.png", scale: 4,)
            ),
          ),
          SizedBox(height: 10,),
          Text(name, style: TextStyle(fontFamily: "Poppins"),)
        ], 
      ),
    );
  }
}