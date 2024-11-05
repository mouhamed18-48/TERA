import 'package:flutter/material.dart';

import '../../constant.dart';

List <DetailsItems> listeDetails = [
  DetailsItems(name: "Ibrahima Dia", quantite: 50, isPositive: true, raison: "livraison"),
  DetailsItems(name: "Ibrahima Dia", quantite: 50, isPositive: true, raison: "livraison"),
  DetailsItems(name: "Ibrahima Dia", quantite: 50, isPositive: true, raison: "livraison"),
  DetailsItems(name: "Ibrahima Dia", quantite: 30, isPositive: false, raison: "vente"),
  DetailsItems(name: "Ibrahima Dia", quantite: 50, isPositive: true, raison: "livraison"),
  DetailsItems(name: "Ibrahima Dia", quantite: 50, isPositive: true, raison: "livraison"),
  DetailsItems(name: "Ibrahima Dia", quantite: 50, isPositive: true, raison: "livraison"),
  DetailsItems(name: "Ibrahima Dia", quantite: 50, isPositive: false, raison: "autres"),
];

class DetailsStocks extends StatefulWidget {
  final String productType;

  const DetailsStocks({
    super.key,
    required this.productType
    });

  @override
  State<DetailsStocks> createState() => _DetailsStocksState();
}

class _DetailsStocksState extends State<DetailsStocks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: teraDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white
            ),
            child: ImageProduct(itemType: widget.productType, imageScale: 13,),
          ),
          SizedBox(height: 20,),
          Container(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: listeDetails,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsItems extends StatelessWidget {
  final String name;
  final int quantite;
  final bool isPositive;
  final String raison;

  const DetailsItems({
    super.key,
    required this.name,
    required this.quantite,
    required this.isPositive,
    required this.raison,
    });

  @override
  Widget build(BuildContext context) {
    Color col = Color.fromARGB(255, 72, 116, 44);
    String arrow = "assets/icons/icons8-fleche-bas-90.png";
    String sign = "+";

    if(!isPositive){
      col = Color.fromARGB(255, 140, 26, 17);
      arrow = "assets/icons/icons8-fleche-haut-90.png";
      sign = "-";
    }

    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      width: MediaQuery.of(context).size.width,
      height: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Image.asset("assets/icons/icons8-utilisateur-sexe-neutre-90.png", scale: 4,),
          SizedBox(width: 10,),
          Text(name, style: TextStyle(fontFamily: "Poppins",),),
          SizedBox(width: 50,),
          Image.asset(arrow, scale: 4,),
          SizedBox(width: 10,),
          Text("$sign $quantite $raison", style: TextStyle(color: col, fontFamily: "Poppins"),)
        ],
      ),
    );
  }
}