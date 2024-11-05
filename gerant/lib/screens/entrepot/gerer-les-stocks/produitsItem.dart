import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../models/Gerant.dart';
import '../../../repository/gerant_repository.dart';
import '../../../shared_preference/gerant_data_manager.dart';
import 'modifier-les-stocks/modifierLesStocksAjout.dart';

class ProduitsItemRow extends StatefulWidget {
  const ProduitsItemRow({super.key});

  @override
  State<ProduitsItemRow> createState() => ProduitsItemRowState();
}

class ProduitsItemRowState extends State<ProduitsItemRow> {
  Future<List<String>?>? futureProduits;
  List<String>? produits;
  Future<Gerant?>? futureGerant;
  Gerant? gerant;

  Future<void> _refreshProduits() async {
    try {
      // Appelez vos fonctions de mise à jour ici
      await _refreshProduitItem(); // Méthode pour mettre à jour les infos de l'entrepôt

      // Afficher un message de succès ou effectuer d'autres actions nécessaires
      print("Page rafraîchie avec succès.");
    } catch (error) {
      // Gérer les erreurs et informer l'utilisateur si nécessaire
      print("Erreur lors du rafraîchissement : $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Erreur lors du rafraîchissement des données')),
      );
    }
  }

  Future<void> _refreshProduitItem() async {
    try {
      // Récupérer les nouveaux items en stock depuis une API ou une base de données
      List<String>? updatedItems = await GerantRepository()
          .getDistinctProductTypes(gerant?.gerantentrepot);

      // Mettre à jour les items en stock dans l'état de l'application
      setState(() {
        produits = updatedItems; // Variable à définir au niveau de la classe
      });
    } catch (error) {
      // Gérer l'erreur et informer l'utilisateur si nécessaire
      print("Erreur lors de la mise à jour des items en stock: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    futureGerant = GerantDataManager.loadStoreData();
    _initProduits();
  }

  Future<void> _initProduits() async {
    gerant = await futureGerant;
    futureProduits =
        GerantRepository().getDistinctProductTypes(gerant?.gerantentrepot);
    futureProduits?.then((produitList) {
      setState(() {
        produits = produitList ??
            []; // Charger les produits récupérés ou une liste vide si null
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshProduits,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: produits != null
              ? (produits!.isNotEmpty
                  ? Row(
                      children:[
                      ProduitsItem(itemType: 'plus', imageScale: 20,),
                      ...produits!.map((produit) {
                        // Dynamique: créer chaque ProduitsItem avec les données récupérées
                        return ProduitsItem(itemType: produit);
                      }).toList(),
                      ]
                    )
                  : ProduitsItem(itemType: 'plus', imageScale: 20))
              : const Center(
                  child: Text(
                    'Chargement...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class ProduitsItem extends StatelessWidget {
  final String itemType;
  double? imageScale;
  ProduitsItem({
    super.key,
    this.imageScale,
    required this.itemType,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => ModifierLesStocks(productType: itemType != "plus"? itemType: null,)));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: teraDark,
        ),
        child: ImageProduct(
          itemType: itemType,
          imageScale: imageScale ?? 15,
        ),
      ),
    );
  }
}
