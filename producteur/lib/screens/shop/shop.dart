import 'package:flutter/material.dart';
import 'package:producteur/constant.dart';
import 'package:producteur/screens/home.dart';
import 'package:producteur/screens/login.dart';
import 'package:producteur/screens/shop/shop_card.dart';
import 'package:producteur/screens/shop/shop_transactions_en_cours.dart';
import 'package:producteur/screens/shop/statistiques_ventes.dart';
import 'package:producteur/shared_preferences/nearest_entrepot_data_manager.dart';
import 'package:producteur/shared_preferences/producteur_data_manager.dart';
import 'package:producteur/shared_preferences/produit_producteur_data_manager.dart';

import '../navbar.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
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
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  icon: const Icon(
                    Icons.notifications,
                    size: 35,
                    color: Colors.black,
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ShopCard(
                  name: "Ibrahima Dia",
                  weight: 54,
                  price: 1000000,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Statistiques des ventes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "assets/icons/icons8-fleche-haut-90.png",
                      scale: 3,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const StatistiquesVentes(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Transactions en cours",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "assets/icons/icons8-chercher-90.png",
                      scale: 3,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const ShopTransactionsEnCours(),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                      color: teraOrange,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      "Historique",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
