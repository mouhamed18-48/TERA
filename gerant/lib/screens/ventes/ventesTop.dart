import 'package:flutter/material.dart';
import 'package:gerant/screens/ventes/ventesTopItems.dart';

import '../../constant.dart';

class ProduitsDisponibles extends StatefulWidget {
  const ProduitsDisponibles({super.key});

  @override
  State<ProduitsDisponibles> createState() => _ProduitsDisponiblesState();
}

class _ProduitsDisponiblesState extends State<ProduitsDisponibles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: teraOrange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 30,
            decoration: BoxDecoration(
                color: teraDarkOrange, borderRadius: BorderRadius.circular(15)),
            child: const Center(
              child: Text(
                "Produits disponibles",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                VentesTopItems(
                    productType: "carotte",
                    prix: 500,
                    numberTransactions: 3,
                    ventes: 50000),
                VentesTopItems(
                    productType: "carotte",
                    prix: 500,
                    numberTransactions: 3,
                    ventes: 50000),
                VentesTopItems(
                    productType: "carotte",
                    prix: 500,
                    numberTransactions: 3,
                    ventes: 50000),
                VentesTopItems(
                    productType: "carotte",
                    prix: 500,
                    numberTransactions: 3,
                    ventes: 50000),
              ],
            ),
          )
        ],
      ),
    );
  }
}
