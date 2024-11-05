import 'package:flutter/material.dart';
import 'package:gerant/screens/entrepot/producteurs.dart';
import 'package:gerant/screens/entrepot/topTitle.dart';

import '../../constant.dart';
import '../../shared_preference/gerant_data_manager.dart';
import '../authentification/login.dart';
import 'itemsEnStock.dart';

class Entrepot extends StatelessWidget {
  const Entrepot({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: teraOrange,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Déconnexion'),
              onTap: () async {
                // Effacer les données stockées et rediriger vers la page de connexion
                await GerantDataManager.removeStoreData();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitle(),
              SizedBox(
                height: 30,
              ),
              Producteurs(),
              SizedBox(
                height: 30,
              ),
              ItemsEnStockCol(),
            ],
          ),
        ),
      ),
    ));
  }
}
