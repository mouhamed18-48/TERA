import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:producteur/constant.dart';

import '../functions/function.dart';
import '../models/EntrepotQuantiteAndProduitForProducteur.dart';
import '../models/Producteur.dart';
import '../models/Produit.dart';
import '../models/ProduitName.dart';
import '../models/ProduitQuantiteProducter.dart';
import '../models/produitByEntrepot.dart';
import '../repositories/produit_repository.dart';
import '../repositories/reservation_repository.dart';
import '../shared_preferences/producteur_data_manager.dart';
import '../shared_preferences/produit_details.dart';
import 'ProductDetails.dart';
import 'ajoutStock.dart';
import 'entrepots.dart';

class AjoutStock extends StatefulWidget {
  const AjoutStock({super.key});

  @override
  State<AjoutStock> createState() => _AjoutStockState();
}

class _AjoutStockState extends State<AjoutStock> {
  Future<List<ProduitQuantiteProducteur>?>? futureProducts;
  List<ProduitQuantiteProducteur>? produitQuantiteListe;
  Future<Producteur?>? futureProducter;
  Producteur? producteur;
  List<Produit>? ProduitInfos;
  Future<List<Produit>?>? futureProduitInfos;
  Future<List<produitByEntrepot>?>? futureProductByEntrepot;
  List<produitByEntrepot>? productByEntrepotListe;
  Future<List<EntrepotQuantiteAndProduitForProducteur>?>?
      futureEntrepotQuantiteAndProduitForProducteur;
  List<EntrepotQuantiteAndProduitForProducteur>?
      EntrepotQuantiteAndProduitForProducteurListe;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureProducter = ProducteurDataManager.loadStoreData();
    futureProduitInfos = ProduitRepository().getProduits();
    futureProduitInfos?.then((produitInformations) {
      setState(() {
        ProduitInfos = produitInformations ??
            []; // Initialement, tous les entrepôts sont affichés
      });
    });
    _initClass(); // Initialisation de la classe pour charger les données du producteur
  }

  Future<void> _initClass() async {
    producteur = await futureProducter;
    setState(() {}); // Rebuild after loading data

    if (producteur != null) {
      // Charger les produits en fonction du numéro de téléphone du producteur
      futureProducts = ProduitRepository()
          .getProductsWithQuantities(producteur?.producterphone);
    }
    futureProducts?.then((produitQuantite) {
      setState(() {
        produitQuantiteListe = produitQuantite ??
            []; // Initialement, tous les entrepôts sont affichés
      });
    });

    if (producteur != null) {
      // Charger les produits en fonction du numéro de téléphone du producteur
      futureProductByEntrepot = ReservationReposity()
          .getProductDetailsByEntrepot(producteur?.producterphone);
    }
    futureProductByEntrepot?.then((ProduitByEntrepot) {
      setState(() {
        productByEntrepotListe = ProduitByEntrepot ??
            []; // Initialement, tous les entrepôts sont affichés
      });
    });

    if (producteur != null) {
      // Charger les produits en fonction du numéro de téléphone du producteur
      futureEntrepotQuantiteAndProduitForProducteur = ReservationReposity()
          .getEntrepotQuantiteAndProduitForProducteur(
              producteur?.producterphone);
    }
    futureEntrepotQuantiteAndProduitForProducteur
        ?.then((entrepotQuantiteAndProduitForProducteur) {
      setState(() {
        EntrepotQuantiteAndProduitForProducteurListe =
            entrepotQuantiteAndProduitForProducteur ??
                []; // Initialement, tous les entrepôts sont affichés
      });
    });
  }

  void showAddStockOverlay(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddStockOverlay();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Row(children: [
                Text(
                  "En stock",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: teraGrey,
                        ),
                        width: 110,
                        height: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: teraDark,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  showAddStockOverlay(context);
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromRGBO(36, 36, 36, 1)),
                              width: 100,
                              height: 50,
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    showAddStockOverlay(context);
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Ajouter",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      FutureBuilder<List<ProduitQuantiteProducteur>?>(
                        future: futureProducts,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child:
                                    Text('Erreur de chargement des produits'));
                          } else if (snapshot.hasData) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  produitQuantiteListe?.length ?? 0,
                                  (index) {
                                    ProduitQuantiteProducteur
                                        produitQuantiteProducteur =
                                        produitQuantiteListe![index];
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 0, 0),
                                      child: Container(
                                        width: 110,
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: GestureDetector(
                                          onTap: () {
                                            ProduitName produitName =
                                                ProduitName(
                                                    produittype:
                                                        produitQuantiteProducteur
                                                            .produittype);

                                            ProduitDetailsDataManager
                                                .saveStorageData(produitName);

                                            //Naviguez vers une autre page en cliquant sur un produit
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Productdetails(),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: teraGrey,
                                                ),
                                                width: 110,
                                                height: 130,
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const SizedBox(),
                                                      SizedBox(
                                                        width: 45,
                                                        height: 45,
                                                        child: Center(
                                                          child: InkWell(
                                                            onTap: () {
                                                              ProduitName
                                                                  produitName =
                                                                  ProduitName(
                                                                      produittype:
                                                                          produitQuantiteProducteur
                                                                              .produittype);

                                                              ProduitDetailsDataManager
                                                                  .saveStorageData(
                                                                      produitName);

                                                              //Naviguez vers une autre page en cliquant sur un produit
                                                              Navigator.push(
                                                                context,
                                                                CupertinoPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const Productdetails(),
                                                                ),
                                                              );
                                                            },
                                                            child: Image.asset(
                                                              getProductImage(
                                                                  produitQuantiteProducteur
                                                                      .produittype),
                                                              scale: 5,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: const Color
                                                                .fromRGBO(
                                                                36, 36, 36, 1)),
                                                        width: 100,
                                                        height: 50,
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                "${produitQuantiteProducteur.totalquantite} Kg",
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Center(
                                                                child: Text(
                                                                  "${getTarifParNom(ProduitInfos, produitQuantiteProducteur.produittype)}/Kg",
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                                child: Text(
                                    "Aucun information n'est disponible pour les produits"));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    "Entrepôts utilisés (${productByEntrepotListe?.length})",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<List<produitByEntrepot>?>(
                future: futureProductByEntrepot,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Erreur de chargement des entrepôts'));
                  } else if (snapshot.hasData) {
                    // Vérifiez si la liste est vide
                    if (productByEntrepotListe == null ||
                        productByEntrepotListe!.isEmpty) {
                      return Center(
                          child: Column(
                        children: [
                          Image.asset(
                            "assets/images/undraw_heavy_box_agqi.png",
                            scale: 5,
                          ),
                          const Text("Aucun entrepôt utilisé pour le moment"),
                        ],
                      ));
                    } else {
                      return Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(36, 36, 36, 1),
                            borderRadius: BorderRadius.circular(7)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: List.generate(
                              productByEntrepotListe?.length ?? 0,
                              (index) {
                                produitByEntrepot produit =
                                    productByEntrepotListe![index];
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${produit.entrepotname}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        height: 80,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 80,
                                              height: 80,
                                              child: Image.asset(
                                                "assets/images/imageentrepot.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              width: 3,
                                              height: 80,
                                              decoration: const BoxDecoration(
                                                color: Color.fromRGBO(
                                                    247, 72, 29, 1),
                                              ),
                                            ),
                                            const SizedBox(width: 17),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/icons/icons8-poids-90.png',
                                                      width: 25,
                                                      height: 25,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      "${produit.totalquantity} Kg",
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      'assets/icons/icons8-colis-ouvert-90.png',
                                                      width: 25,
                                                      height: 25,
                                                      color: Colors.black,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      "${produit.distinctProductCount} items en stock",
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            Container(
                                              width: 10,
                                              decoration: const BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      247, 72, 29, 1)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    return const Center(
                        child: Text(
                            "Aucun information n'est disponible pour les produits"));
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Stockage en cours (${EntrepotQuantiteAndProduitForProducteurListe?.length})",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
              FutureBuilder<List<EntrepotQuantiteAndProduitForProducteur>?>(
                future: futureEntrepotQuantiteAndProduitForProducteur,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Erreur de chargement des produits'));
                  } else if (snapshot.hasData) {
                    // Vérifiez si la liste est vide
                    if (EntrepotQuantiteAndProduitForProducteurListe == null ||
                        EntrepotQuantiteAndProduitForProducteurListe!.isEmpty) {
                      return Column(
                        children: [
                          Image.asset(
                            "assets/images/undraw_logistics_x4dc.png",
                            scale: 4,
                          ),
                          const Center(child: Text("Aucun stockage en cours")),
                        ],
                      );
                    } else {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: List.generate(
                              EntrepotQuantiteAndProduitForProducteurListe
                                      ?.length ??
                                  0,
                              (index) {
                                EntrepotQuantiteAndProduitForProducteur
                                    produit =
                                    EntrepotQuantiteAndProduitForProducteurListe![
                                        index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  width: MediaQuery.of(context).size.width,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:
                                        const Color.fromRGBO(217, 217, 217, 1),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 70,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              getProductImage(
                                                  produit.produittype),
                                              height: 40,
                                              width: 70,
                                            ),
                                            Container(
                                              width: 1,
                                              height: 80,
                                              decoration: const BoxDecoration(
                                                color: Color.fromRGBO(
                                                    247, 72, 29, 1),
                                              ),
                                            ),
                                            const SizedBox(width: 17),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/icons/icons8-poids-90.png',
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          "${produit.quantite} Kg",
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                        height: 10),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/icons/hangar-icon.png',
                                                          width: 25,
                                                          height: 25,
                                                          color: Colors.black,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          "${produit.entrepotname}",
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 20,),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/Schedule.png',
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          "${produit.temps_restant_jours} jours",
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                        height: 10),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/icons/icons8-livraison-90.png',
                                                          width: 25,
                                                          height: 25,
                                                          color: Colors.black,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        const Text(
                                                          "7 jours",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    return const Center(
                        child: Text(
                            "Aucun information n'est disponible pour les produits"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
