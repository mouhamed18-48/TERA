import 'package:flutter/material.dart';
import 'package:producteur/constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../functions/function.dart';
import '../models/Entrepot.dart';
import '../models/Producteur.dart';
import '../models/ReservedProductsEntrepot.dart';
import '../repositories/produit_repository.dart';
import '../repositories/reservation_repository.dart';
import '../shared_preferences/entrepot_data_manager.dart';
import '../shared_preferences/producteur_data_manager.dart';
import 'ajoutStock.dart';
import 'map.dart';

class InfosEntrepot extends StatefulWidget {
  const InfosEntrepot({super.key});

  @override
  State<InfosEntrepot> createState() => _InfosEntrepotState();
}

class _InfosEntrepotState extends State<InfosEntrepot> {
  final ScrollController _scrollController = ScrollController(); // Ajouté

  Future<Producteur?>? futureProducter;
  Future<Entrepot?>? futureEntrepot;
  Producteur? producteur;
  Entrepot? entrepot;
  Future<List<Reservedproductsentrepot>?>? futureReservedproductsentrepot;
  List<Reservedproductsentrepot>? reservedproductsentrepotList;
  Future<List<String>?>? futureProduit;
  List<String>? produits;

  @override
  void initState() {
    super.initState();
    futureProducter = ProducteurDataManager.loadStoreData();
    futureEntrepot = EntrepotDataManager.loadStoreData();
    _initClass();
  }

  Future<void> _initClass() async {
    producteur = await futureProducter;
    entrepot = await futureEntrepot;
    setState(() {}); // Rebuild after loading data
    EntrepotDataManager.removeStoreData();

    if (producteur != null) {
      // Charger les produits en fonction du numéro de téléphone du producteur
      futureReservedproductsentrepot = ReservationReposity()
          .getReservedProductsEntrepot(
              producteur?.producterphone, entrepot?.entrepotnom);
    }
    futureReservedproductsentrepot?.then((produitQuantite) {
      setState(() {
        reservedproductsentrepotList = produitQuantite ??
            []; // Initialement, tous les entrepôts sont affichés
      });
    });

    futureProduit =
        ProduitRepository().getEntrepotProduit(entrepot?.entrepotid);
    produits = await futureProduit;
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
          // Ajout du SingleChildScrollView ici
          child: Column(
            children: [
              Center(
                child: Text(
                  "${entrepot?.entrepotnom}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 400,
                width: double.infinity,
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(36, 36, 36, 1)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        width: double.maxFinite,
                        height: 250,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/images/imageentrepot.png",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 105,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(247, 72, 29, 1)),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(211, 61, 24, 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Remplacez par les coordonnées réelles de votre entrepôt
                                      double latitude =
                                          entrepot?.entrepotlatitude ?? 0.0;
                                      double longitude =
                                          entrepot?.entrepotlongitude ?? 0.0;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Map(
                                            latitude: latitude,
                                            longitude: longitude,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/place-icon.png",
                                          width: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          "Insert location",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/icons8-telephone-90.png",
                                        width: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${entrepot?.contact}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/colis-ouvert.png",
                                        color: Colors.white,
                                        width: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${reservedproductsentrepotList?.length ?? 0} items en stock",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/poids-icon.png",
                                        width: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${entrepot?.entrepotcapacite?.toInt()} Kg libre",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Items conservables",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              FutureBuilder<List<String>?>(
                future: futureProduit,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Erreur: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: const BoxDecoration(color: teraGrey),
                        child: Scrollbar(
                          thumbVisibility: true,
                          controller: _scrollController, // Ajouté
                          thickness: 5,
                          child: SingleChildScrollView(
                            controller: _scrollController, // Ajouté
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                produits?.length ?? 0,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              36, 36, 36, 1),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Image.asset(
                                        getProductImage(produits![index]),
                                        scale: 13,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                        child: Text('Aucun Produit conservable'));
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Items en stock",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              FutureBuilder<List<Reservedproductsentrepot>?>(
                future: futureReservedproductsentrepot,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Erreur de chargement"));
                  } else if (snapshot.hasData &&
                      (reservedproductsentrepotList?.isNotEmpty ?? false)) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: teraDark,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: List.generate(
                            reservedproductsentrepotList?.length ?? 0,
                            (index) {
                              Reservedproductsentrepot produit =
                                  reservedproductsentrepotList![index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                height: 80,
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      getProductImage(produit.produittype),
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(width: 20),
                                    Container(
                                      width: 2,
                                      color: teraYellow,
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/poids-icon.png",
                                              width: 20,
                                              height: 20,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "${produit.totalquantite} Kg",
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/icons8-coeur-en-bonne-sante-90.png",
                                              width: 20,
                                              height: 20,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              "Bon état",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            const SizedBox(width: 5),
                                            Text(
                                              "+${produit.total_quantite_aujourd_hui} Kg aujourd'hui",
                                              style: const TextStyle(
                                                  color: Colors.green),
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
                                            const SizedBox(width: 5),
                                            Text(
                                              "-${produit.total_quantite_7_jours} Kg dans 7 jours",
                                              style: const TextStyle(
                                                  color: Colors.red),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                        child: Column(
                      children: [
                        Image.asset(
                          "assets/images/undraw_Healthy_options_re_lf9l.png",
                          scale: 5,
                        ),
                        const Text("Aucun Produit en stock dans cet entrepôt"),
                      ],
                    ));
                  }
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          width: double.infinity,
          child: Center(
            child: Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.orange[900],
                borderRadius: BorderRadius.circular(5),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.transparent),
                  elevation: WidgetStateProperty.all(0),
                ),
                child: GestureDetector(
                  onTap: () {
                    showAddStockOverlay(context);
                  },
                  child: const Text(
                    "Stocker",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
