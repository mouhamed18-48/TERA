import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:producteur/constant.dart';
import 'package:producteur/screens/home.dart';

import '../Color/constants.dart';
import '../functions/function.dart';
import '../models/Producteur.dart';
import '../models/ProduitName.dart';
import '../models/QuantitiesByEntrepot.dart';
import '../repositories/reservation_repository.dart';
import '../shared_preferences/producteur_data_manager.dart';
import '../shared_preferences/produit_details.dart';
import 'ajoutStock.dart';

class Productdetails extends StatefulWidget {
  const Productdetails({super.key});

  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
  Future<Producteur?>? futureProducter;
  Future<ProduitName?>? futureProduit;
  Producteur? producteur;
  ProduitName? produit;
  Future<List<QuantitiesByEntrepot>?>? futureQuantitiesByEntrepot;
  List<QuantitiesByEntrepot>? quantitiesByEntrepotList;

  @override
  void initState() {
    super.initState();
    futureProducter = ProducteurDataManager.loadStoreData();
    futureProduit = ProduitDetailsDataManager.loadStoreData();
    _initClass();
  }

  Future<void> _initClass() async {
    producteur = await futureProducter;
    produit = await futureProduit;
    setState(() {}); // Rebuild after loading data
    ProduitDetailsDataManager.removeStoreData();

    if (producteur != null) {
      // Charger les produits en fonction du numéro de téléphone du producteur
      futureQuantitiesByEntrepot = ReservationReposity()
          .getQuantitiesByEntrepot(
              producteur?.producterphone, produit?.produittype);
    }
    futureQuantitiesByEntrepot?.then((produitQuantite) {
      setState(() {
        quantitiesByEntrepotList = produitQuantite ??
            []; // Initialement, tous les entrepôts sont affichés
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                      width: 500,
                      height: 130,
                      decoration: BoxDecoration(
                        color: orange,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            "${produit?.produittype}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${calculerTotalQuantite(quantitiesByEntrepotList).toInt()}kg stocké dans ${quantitiesByEntrepotList?.length} entrepots",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -50,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: teraDark,
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.asset(
                          getProductImage(produit?.produittype),
                          scale: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Entrepôts utilisés : ${quantitiesByEntrepotList?.length}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Container(
                height: 250,
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Scrollbar(
                  thickness: 8,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Affichage dynamique des entrepôts
                        if (quantitiesByEntrepotList != null &&
                            quantitiesByEntrepotList!.isNotEmpty)
                          ...quantitiesByEntrepotList!.map((entrepot) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.only(right: 20),
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 5),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: Image.asset(
                                      "assets/images/imageentrepot.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        entrepot.entrepotnom ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${entrepot.totalquantite?.toInt()} kg stockés',
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/icons/icons8-fleche-bas-90.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                          Text(
                                            "+${entrepot.total_quantite_aujourd_hui} Kg aujourd'hui",
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/UpArrow.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                          Text(
                                            "-${entrepot.total_quantite_7_jours} Kg dans 7 jours",
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          })
                        else
                          const Text("Aucun entrepôt disponible."),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    showAddStockOverlay(context);
                  },
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        color: teraOrange,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Text(
                        "Ajouter",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Transactions en cours",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: lightGrey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Transaction(name: "Abdourahmane", price: 1200, idTransaction: "C-103", weight: 13, productType: "carotte",),
                      Transaction(name: "Abdourahmane", price: 1200, idTransaction: "C-103", weight: 13, productType: "carotte",),
                      Transaction(name: "Ibrahima", price: 1200, idTransaction: "C-103", weight: 13, productType: "carotte",),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
