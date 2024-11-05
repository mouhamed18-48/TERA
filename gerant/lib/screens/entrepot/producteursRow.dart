import 'package:flutter/material.dart';
import 'package:gerant/screens/entrepot/producteursItem.dart';

import '../../constant.dart';
import '../../models/Gerant.dart';
import '../../models/ProduitProducer.dart';
import '../../models/Produteur.dart';
import '../../repository/gerant_repository.dart';
import '../../shared_preference/gerant_data_manager.dart';

class ProducteursRow extends StatefulWidget {
  const ProducteursRow({super.key});

  @override
  State<ProducteursRow> createState() => _ProducteursRowState();
}

class _ProducteursRowState extends State<ProducteursRow> {
  Future<List<Producteur>?>? futureProducteur;
  List<Producteur>? Producteurs;
  Future<Gerant?>? futureGerant;
  Gerant? gerant;
  Future<List<ProduitProducer>?>? futureProduits;
  List<ProduitProducer>? Produits;
  Map<String, List<ProduitProducer>> produitsParProducteur = {};

  @override
  void initState() {
    super.initState();
    futureGerant = GerantDataManager.loadStoreData();
    _initClass();
  }

  Future<void> _initClass() async {
    gerant = await futureGerant;
    futureProducteur =
        GerantRepository().getDistinctProducteur(gerant?.gerantentrepot);
    futureProducteur?.then((producteursList) async {
      setState(() {
        Producteurs = producteursList ?? [];
      });

      // Charger les produits pour chaque producteur
      for (var producteur in Producteurs!) {
        await _loadProduitsForProducteur(producteur);
      }
      setState(
          () {}); // Mettre à jour l'interface après avoir chargé les produits
    });
  }

  // Fonction pour charger les produits pour un producteur donné
  Future<void> _loadProduitsForProducteur(Producteur producteur) async {
    List<ProduitProducer>? produits =
        await GerantRepository().getProduitProducer(
      gerant?.gerantentrepot,
      producteur.producterphone,
    );

    if (produits != null) {
      produitsParProducteur[producteur.producterphone!] = produits;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      width: MediaQuery.of(context).size.width / 1.15,
      height: 278,
      decoration: BoxDecoration(
          color: Producteurs != null && Producteurs!.isNotEmpty
              ? teraGrey
              : Colors.white),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Producteurs != null && Producteurs!.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: Producteurs!.map((producteur) {
                    // Obtenir la liste des produits pour ce producteur
                    List<ProduitProducer> produits =
                        produitsParProducteur[producteur.producterphone] ?? [];

                    // Créer une liste de ProductItem à partir des produits récupérés
                    List<ProductItem> ListeItems = produits
                        .map((produit) => ProductItem(
                              productType:
                                  produit.resproduit.toString() ?? "Inconnu",
                              quantity: produit.totalquantite.toString() ?? "0",
                            ))
                        .toList();

                    return ProducteursItem(
                      name:
                          "${producteur.producterfirstname} ${producteur.productersecondname}",
                      listeItems: ListeItems,
                    );
                  }).toList(),
                ))
            : Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/undraw_farm_girl_dnpe.png",
                      scale: 4,
                    ),
                    const Text(
                      'Aucun Producteur', // Message lorsque la liste est vide
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
