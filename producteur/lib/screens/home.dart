// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:producteur/constant.dart';
import 'package:producteur/repositories/reservation_repository.dart';
import '../Color/constants.dart';
import '../functions/getLocation.dart';
import '../models/Nearreastentrepot.dart';
import '../models/Producteur.dart';
import '../models/Produit.dart';
import '../models/ProduitName.dart';
import '../repositories/entrepot_repository.dart';
import '../repositories/produit_repository.dart';
import '../shared_preferences/nearest_entrepot_data_manager.dart';
import '../shared_preferences/producteur_data_manager.dart';
import '../shared_preferences/produit_details.dart';
import '../shared_preferences/produit_producteur_data_manager.dart';
import 'ProductDetails.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> nearestEntrepot = <String, dynamic>{};
  Future<Producteur?>? futureProducter;
  Future<List<String>?>? futureProduit;
  Future<List<Produit>?>? futureProduitInfos;
  List<Produit>? ProduitInfos;
  Producteur? producteur;
  List<String>? produits;
  Future<Nearreastentrepot?>? futureNearest;
  Nearreastentrepot? nearreastentrepot;

  @override
  void initState() {
    super.initState();
    futureProducter = ProducteurDataManager.loadStoreData();
    futureProduitInfos = ProduitRepository().getProduits();
    futureProduitInfos?.then((produitInformations) {
      setState(() {
        ProduitInfos = produitInformations ??
            []; // Initialement, tous les entrepôts sont affichés
      });
    });
    _initClass();
  }

  Future<void> _initClass() async {
    producteur = await futureProducter;
    setState(() {});
    futureProduit = ReservationReposity()
        .getDistinctProductTypes(producteur?.producterphone);
    futureProduit?.then((produitInformations) {
      setState(() {
        produits = produitInformations ??
            []; // Initialement, tous les entrepôts sont affichés
      });
    });
    setState(() {});
    Position? currentPosition = await getLocation();
    futureNearest = EntrepotRepository().getNearestEntrepot(
      currentPosition!.latitude,
      currentPosition.longitude,
      producteur?.producterphone,
    );
    futureNearest?.then((Nearest) {
      setState(() {
        nearreastentrepot =
            Nearest; // Initialement, tous les entrepôts sont affichés
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: orange,
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () async {
                  // Effacer les données stockées et rediriger vers la page de connexion
                  await ProducteurDataManager.removeStoreData();
                  await ProduitProducteurDataManager.removeStoreData();
                  await NearestEntrepotDataManager.removeStoreData();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: Icon(
                  Icons.logout,
                  size: 35,
                  color: Colors.white,
                ),
              );
            },
          ),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  icon: Icon(
                    Icons.notifications,
                    size: 35,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    height: 220,
                    color: orange,
                  ),
                  Positioned(
                    bottom: -50,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          height: 230,
                          width: MediaQuery.of(context).size.width / 1.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: dark,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/user-icon.png',
                                              width: 17,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              (producteur?.producterfirstname)
                                                  .toString()
                                                  .split(' ')[0],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/vente-icon.png',
                                              width: 17,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              '5 ventes',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/poids-icon.png',
                                              width: 17,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              '350kg',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Entrepôt proche',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: jauneClair,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: teraDarkYellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Center(
                                                  child: Text(
                                                    (nearreastentrepot
                                                            ?.entrepotNom)
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/icons/place-icon.png',
                                                        width: 17,
                                                        color: Colors.black,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        '${(double.parse(nearreastentrepot?.distanceKm?.toString() ?? '0')).toStringAsFixed(2)} km',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/icons/hangar-icon.png',
                                                        width: 17,
                                                        color: Colors.black,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        "${nearreastentrepot?.entrepotCapaciteTotal?.toInt()} Kg libre",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/icons/colis-ouvert.png',
                                                        width: 17,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        '${nearreastentrepot?.nombre_produits} en stock',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ]),
                        ),
                        Positioned(
                            top: -40,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100)),
                              clipBehavior: Clip.hardEdge,
                              child: Image(
                                image: AssetImage(
                                  'assets/images/Tera2.png',
                                ),
                                width: 60,
                                fit: BoxFit.fill,
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/icons/colis-ouvert.png', width: 20),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Items en stock',
                          style: TextStyle(
                              color: dark,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    produits != null && produits!.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                            color: teraGrey,
                            width: MediaQuery.of(context).size.width,
                            height: 80, // Ajustez la hauteur selon vos besoins
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: produits!.length,
                              itemBuilder: (context, index) {
                                String produit = produits![index];
                                String iconPath;

                                // Associez chaque produit à une icône spécifique
                                switch (produit) {
                                  case "patate":
                                    iconPath = 'assets/images/patate.png';
                                    break;
                                  case "carotte":
                                    iconPath = 'assets/images/les-carottes.png';
                                    break;
                                  case "cacahuete":
                                    iconPath = 'assets/images/cacahuete.png';
                                    break;
                                  default:
                                    iconPath =
                                        'assets/icons/default-icon.png'; // Icône par défaut
                                }

                                return GestureDetector(
                                  onTap: () {
                                    ProduitName produitName =
                                        ProduitName(produittype: produit);

                                    ProduitDetailsDataManager.saveStorageData(
                                        produitName);

                                    //Naviguez vers une autre page en cliquant sur un produit
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => Productdetails(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: teraDark,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Image.asset(
                                      iconPath,
                                      scale: 12,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/undraw_empty_cart_co35.png",
                                  scale: 5,
                                ),
                                Text(
                                  'Aucun produit en stock.',
                                  style: TextStyle(
                                      color: dark, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<List<Produit>?>(
                      future: futureProduitInfos,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text('Erreur de chargement des entrepôts'));
                        } else if (snapshot.hasData) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                ProduitInfos?.length ?? 0,
                                (index) {
                                  Produit produit = ProduitInfos![index];
                                  return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/augmenter.png",
                                          scale: 17,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "+${produit.produitprix}F/kg",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${produit.produittype}",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        const SizedBox(width: 25),
                                        Container(
                                          width: 2,
                                          height: 50,
                                          color: Color.fromARGB(
                                              255, 217, 217, 217),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        } else {
                          return Center(
                              child: Text(
                                  "Aucun information n'est disponible pour les produits"));
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Transaction en cours',
                          style: TextStyle(
                              color: dark,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Expanded(child: Container()),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'voir tout >',
                              style: TextStyle(
                                  color: orange, fontWeight: FontWeight.w400),
                            )),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      decoration: BoxDecoration(
                          color: teraGrey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Transaction(
                            name: "Ibrahima Dia",
                            idTransaction: "C103",
                            price: 1200,
                            weight: 40,
                            productType: "carotte",
                          ),
                          Transaction(
                            name: "Mohamed El Amine Sembene",
                            idTransaction: "C103",
                            price: 1200,
                            weight: 40,
                            productType: "carotte",
                          ),
                          Transaction(
                            name: "Abdourahmane Ka",
                            idTransaction: "C103",
                            price: 1200,
                            weight: 40,
                            productType: "carotte",
                          ),
                          Transaction(
                            name: "Ibrahima Dia",
                            idTransaction: "C103",
                            price: 1200,
                            weight: 40,
                            productType: "carotte",
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

class Transaction extends StatelessWidget {
  String? name;
  String? idTransaction;
  double? price;
  double? weight;
  String? productType;

  Transaction(
      {super.key,
      this.name,
      this.idTransaction,
      this.price,
      this.weight,
      this.productType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 90,
      color: teraDark,
      child: Row(
        children: [
          ImageProduct(
            itemType: productType!,
            imageScale: 10,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: teraOrange,
            width: MediaQuery.of(context).size.width / 2.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/poids-icon.png',
                          scale: 4,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "$weight kg",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/icons8-sac-dargent-90.png',
                          scale: 4,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "$price f",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/user-icon.png',
                          scale: 4,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          name!.split(' ')[0].length > 8
                              ? "${name!.split(' ')[0].substring(0, 5)}..."
                              : name!.split(' ')[0],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/icons8-etiquette-90.png',
                          scale: 4,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "$idTransaction",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                children: [
                  Text(
                    "Plus",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
