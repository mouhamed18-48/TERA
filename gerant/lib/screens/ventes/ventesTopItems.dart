import 'package:flutter/material.dart';

import '../../constant.dart';

class VentesTopItems extends StatelessWidget {
  final String productType;
  final int prix;
  final int numberTransactions;
  String imagePath;
  final int ventes;

  VentesTopItems({
    super.key,
    required this.productType,
    required this.prix,
    required this.numberTransactions,
    this.imagePath = '',
    required this.ventes
    });

  @override
  Widget build(BuildContext context) {
    if(productType == "carotte"){
      imagePath = "assets/les-carottes.png";
    }
    if(productType == "pomme de terre"){
      imagePath = "assets/patate.png";
    }
    if(productType == "arachide"){
      imagePath = "assets/cacahuete.png";
    }

    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      padding: EdgeInsets.all(10),
      width: 160,
      height: 130,
      decoration: BoxDecoration(
        color: teraDark,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(imagePath, scale: 13,),
              SizedBox(width: 5,),
              Text(
                "${prix} F/Kg",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                 fontFamily: "Poppins",
                  color: Colors.white,
                   fontSize: 18),),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Image.asset("assets/icons/icons8-mots-cles-90.png", scale: 5,),
              SizedBox(width: 5,),
              Text(
                "${3} transactions",
              style: TextStyle(
                 fontFamily: "Poppins",
                  color: Colors.white,
                   fontSize: 15),),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Image.asset("assets/icons/icons8-sac-dargent-90.png", scale: 5,),
              SizedBox(width: 5,),
              Text(
                "${500000} Fcfa",
              style: TextStyle(
                 fontFamily: "Poppins",
                  color: Colors.white,
                   fontSize: 15),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Image.asset("assets/icons/icons8-plus-90.png", color: Colors.white, scale: 5,)
            ],
          )
        ],
      ),
    );
  }
}