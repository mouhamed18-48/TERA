import "package:flutter/material.dart";
import "package:gerant/screens/homepage/top.dart";

import "../../constant.dart";
import "../../shared_preference/gerant_data_manager.dart";
import "../authentification/login.dart";
import "evolutionDesPrix.dart";
import "infosEntrepot.dart";
import "itemsEnStock.dart";
import "livraisonsEnCours.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: teraOrange,
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () async {
                  // Effacer les données stockées et rediriger vers la page de connexion
                  await GerantDataManager.removeStoreData();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(
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
                  icon: const Icon(
                    Icons.notifications,
                    size: 35,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: const SingleChildScrollView(
          child: Column(
            children: [
              Top(),
              SizedBox(
                height: 20,
              ),
              ItemsEnStock(),
              SizedBox(
                height: 30,
              ),
              LivraisonsEnCours(),
              SizedBox(
                height: 30,
              ),
              EvolutionDesPrix(),
              SizedBox(
                height: 30,
              ),
              InfosEntrepot(),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
