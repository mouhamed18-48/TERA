import "package:flutter/material.dart";

import "../../constant.dart";
import "../../models/Produit.dart";
import "../../repository/gerant_repository.dart";

class EvolutionDesPrix extends StatefulWidget {
  const EvolutionDesPrix({super.key});

  @override
  State<EvolutionDesPrix> createState() => _EvolutionDesPrixState();
}

class _EvolutionDesPrixState extends State<EvolutionDesPrix> {
  Future<List<Produit>?>? futureProduitInfos;
  List<Produit>? produitInfos = []; // Initialiser avec une liste vide

  @override
  void initState() {
    super.initState();
    futureProduitInfos = GerantRepository().getProduits();
    futureProduitInfos?.then((produitInformations) {
      setState(() {
        produitInfos = produitInformations ?? []; // Initialement, tous les entrepôts sont affichés
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Evolution des prix de vente",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10,),
          produitInfos != null && produitInfos!.isNotEmpty
              ? _buildProduitInfos() // Utiliser une méthode pour afficher les produits
              : Center(child: CircularProgressIndicator()), // Indicateur de chargement

        ],
      ),
    );
  }

  Widget _buildProduitInfos() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: produitInfos!.map((produit) {
          // Remplacez les données statiques par les données du produit
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Remplacez ces images et informations par celles des produits
              Image.asset(
                 'assets/augmenter.png',
                scale: 20,
              ),
              SizedBox(width: 10),
              Text(
                "${produit.produitprix}f/Kg",
                style: TextStyle(
                  fontFamily: "Poppins",
                  color:Color.fromARGB(255, 72, 116, 44),
                ),
              ),
              SizedBox(width: 5),
              Text(
                produit.produittype.toString(),
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Color.fromARGB(255, 72, 116, 44),
                ),
              ),
              SizedBox(width: 30),
              Container(
                width: 2,
                height: 50,
                color: teraGrey,
              ),
              SizedBox(width: 10),
            ],
          );
        }).toList(),
      ),
    );
  }
}








