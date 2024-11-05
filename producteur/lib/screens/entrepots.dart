import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:producteur/constant.dart';
import 'package:producteur/screens/production_infos.dart';
import 'package:producteur/screens/stock.dart';

import '../Color/constants.dart';
import '../functions/function.dart';
import '../models/Entrepot.dart';
import '../models/Producteur.dart';
import '../models/ProduitName.dart';
import '../models/ProduitQuantiteProducter.dart';
import '../repositories/entrepot_repository.dart';
import '../repositories/production_repository.dart';
import '../repositories/produit_repository.dart';
import '../shared_preferences/entrepot_data_manager.dart';
import '../shared_preferences/nearest_entrepot_data_manager.dart';
import '../shared_preferences/producteur_data_manager.dart';
import '../shared_preferences/produit_details.dart';
import '../shared_preferences/produit_producteur_data_manager.dart';
import 'ProductDetails.dart';
import 'infos_entrpots.dart';
import 'login.dart';
import 'navbar.dart';

class Entrepots extends StatefulWidget {
  const Entrepots({super.key});

  @override
  State<Entrepots> createState() => _EntrepotsState();
}

class _EntrepotsState extends State<Entrepots> {
  Future<List<Entrepot>?>? futureEntrepots;
  List<Entrepot>? allEntrepots; // Stocker tous les entrepôts
  List<Entrepot>? filteredEntrepots; // Stocker les entrepôts filtrés
  TextEditingController searchController = TextEditingController();
  Future<List<ProduitQuantiteProducteur>?>? futureProducts;
  Future<Producteur?>? futureProducter;
  Producteur? producteur;
  List<ProduitQuantiteProducteur>? produitQuantiteListe;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureEntrepots = EntrepotRepository().getAllEntrepot();
    futureEntrepots?.then((entrepots) {
      setState(() {
        allEntrepots = entrepots ?? [];
        filteredEntrepots =
            allEntrepots; // Initialement, tous les entrepôts sont affichés
      });
    });
    futureProducter = ProducteurDataManager.loadStoreData();
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
  }

  void filterEntrepots(String query) {
    if (query.isEmpty) {
      // Si la recherche est vide, afficher tous les entrepôts
      setState(() {
        filteredEntrepots = allEntrepots;
      });
    } else {
      // Filtrer les entrepôts par nom
      setState(() {
        filteredEntrepots = allEntrepots
            ?.where((entrepot) => entrepot.entrepotnom
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  // Ajoutez cette méthode pour vérifier et diriger l'utilisateur
  void _gererProduction(String producteurPhone) async {
    try {
      bool productionExists =
          await ProductionRepository().checkProductionExists(producteurPhone);

      if (!productionExists) {
        // Si la production n'existe pas, afficher une boîte de dialogue pour renseigner les informations
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: Wrap(
                children: [
                  AlertDialog(
                    backgroundColor: Colors.white,
                    content: Column(
                      children: [
                        Image.asset(
                          "assets/icons/icons8-info-90.png",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Veuillez renseigner les informations de votre production d’abord!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const ProductionInfos(),
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                                color: teraOrange,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                                child: Text(
                              "Renseigner",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      } else {
        // Si la production existe, rediriger vers le dashboard
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const AjoutStock(),
          ),
        );
      }
    } catch (e) {
      print("Erreur: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage(
                          "assets/images/image-entrepot.png",
                        ),
                        fit: BoxFit.fitWidth)),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(150, 255, 255, 255),
                                borderRadius: BorderRadius.circular(70)),
                            child: Builder(
                              builder: (context) {
                                return IconButton(
                                  onPressed: () async {
                                    // Effacer les données stockées et rediriger vers la page de connexion
                                    await ProducteurDataManager
                                        .removeStoreData();
                                    await ProduitProducteurDataManager
                                        .removeStoreData();
                                    await NearestEntrepotDataManager
                                        .removeStoreData();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.logout,
                                    size: 35,
                                    color: Colors.black,
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(150, 255, 255, 255),
                                borderRadius: BorderRadius.circular(70)),
                            child: Builder(
                              builder: (context) {
                                return IconButton(
                                  onPressed: () =>
                                      Scaffold.of(context).openEndDrawer(),
                                  icon: const Icon(
                                    Icons.notifications,
                                    size: 35,
                                    color: Colors.black,
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 230),
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                          color: teraDark,
                          borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(70),
                              topStart: Radius.circular(70))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FutureBuilder<List<Entrepot>?>(
                            future: futureEntrepots,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Erreur: ${snapshot.error}'),
                                );
                              } else if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Les Entrepôts disponibles",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: teraOrange,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Container(
                                        height: 34,
                                        width: 185,
                                        decoration: BoxDecoration(
                                          color: teraDarkOrange,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: TextField(
                                          controller: searchController,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          onChanged: filterEntrepots,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 8),
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  searchController.clear();
                                                  filterEntrepots('');
                                                },
                                                icon: const Icon(Icons.search),
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 0.7),
                                              ),
                                              hintText: "Chercher...",
                                              hintStyle: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.7))),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                            filteredEntrepots?.length ?? 0,
                                            (index) {
                                              Entrepot entrepot =
                                                  filteredEntrepots![index];
                                              return GestureDetector(
                                                onTap: () {
                                                  Entrepot entrepotInfos = Entrepot(
                                                      entrepotnom:
                                                          entrepot.entrepotnom,
                                                      entrepotid:
                                                          entrepot.entrepotid,
                                                      entrepotadresse: entrepot
                                                          .entrepotadresse,
                                                      entrepotcapacite: entrepot
                                                          .entrepotcapacite,
                                                      entrepotlatitude: entrepot
                                                          .entrepotlatitude,
                                                      entrepotlongitude: entrepot
                                                          .entrepotlongitude,
                                                      contact:
                                                          entrepot.contact);
                                                  EntrepotDataManager
                                                      .saveStorageData(
                                                          entrepotInfos);
                                                  Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                      builder: (context) =>
                                                          const InfosEntrepot(),
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Container(
                                                    width: 150,
                                                    height: 200,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Column(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          child: Image.asset(
                                                            "assets/images/image-entrepot.png",
                                                            width:
                                                                double.infinity,
                                                            height: 130,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Container(
                                                          color: Colors
                                                              .orange[900],
                                                          height: 6,
                                                          width:
                                                              double.infinity,
                                                        ),
                                                        Text(
                                                          entrepot.entrepotnom
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 17),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children: [
                                                            const SizedBox(
                                                                width: 10),
                                                            Image.asset(
                                                              'assets/icons/hangar-icon.png',
                                                              width: 20,
                                                              height: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Text(
                                                              "${entrepot.entrepotcapacite?.toInt()} kg libre",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                );
                              } else {
                                return const Center(
                                    child: Text('Aucun entrepôt disponible'));
                              }
                            },
                          ),

                          // Cette section sera toujours visible
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                const Text(
                                  "Items en stock",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    _gererProduction(
                                        producteur?.producterphone ?? "");
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: teraOrange,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Gérer",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                FutureBuilder<List<ProduitQuantiteProducteur>?>(
                                  future: futureProducts,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return const Center(
                                        child: Text(
                                            'Erreur de chargement des produits'),
                                      );
                                    } else if (snapshot.hasData) {
                                      if (produitQuantiteListe == null ||
                                          produitQuantiteListe!.isEmpty) {
                                        return Center(
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                  "assets/images/undraw_Not_found_re_bh2e.png"),
                                              const Text(
                                                "Aucun produit stocké dans les entrepôts",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            children: List.generate(
                                              produitQuantiteListe?.length ?? 0,
                                              (index) {
                                                ProduitQuantiteProducteur
                                                    produit =
                                                    produitQuantiteListe![
                                                        index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      ProduitName produitName =
                                                          ProduitName(
                                                              produittype: produit
                                                                  .produittype);
                                                      ProduitDetailsDataManager
                                                          .saveStorageData(
                                                              produitName);

                                                      // Naviguer vers une autre page en cliquant sur un produit
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                          builder: (context) =>
                                                              const Productdetails(),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          20, 0, 20, 0),
                                                      height: 80,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                            getProductImage(
                                                                produit
                                                                    .produittype),
                                                            width: 40,
                                                            height: 40,
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Container(
                                                            width: 2,
                                                            height: 80,
                                                            color: teraYellow,
                                                          ),
                                                          const SizedBox(
                                                              width: 8),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/icons/poids-icon.png",
                                                                    width: 25,
                                                                    height: 25,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    "${produit.totalquantite}KG",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Row(
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/icons/icons8-coeur-en-bonne-sante-90.png",
                                                                    width: 25,
                                                                    height: 25,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  const Text(
                                                                    "Bon état",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          const Spacer(),
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
                                                                    "assets/icons/icons8-fleche-bas-90.png",
                                                                    width: 20,
                                                                    height: 20,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    "+${produit.total_quantite_aujourd_hui} Kg aujourd'hui",
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Row(
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/images/UpArrow.png",
                                                                    width: 20,
                                                                    height: 20,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    "-${produit.total_quantite_7_jours} Kg dans 7 jours",
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
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
                                      }
                                    } else {
                                      return const Center(
                                          child: Text(
                                              "Aucune information disponible pour les produits"));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
