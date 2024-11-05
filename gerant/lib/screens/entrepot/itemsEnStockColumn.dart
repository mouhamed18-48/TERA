import 'package:flutter/material.dart';
import '../../constant.dart';
import '../../models/Gerant.dart';
import '../../models/ProduitEntrepot.dart'; // Assurez-vous d'importer ce modèle
import '../../repository/gerant_repository.dart';
import '../../shared_preference/gerant_data_manager.dart';
import 'detailsStocks.dart';
import 'itemsEnStockColumnItem.dart';

class ItemsEnStockColumn extends StatefulWidget {
  const ItemsEnStockColumn({super.key});

  @override
  State<ItemsEnStockColumn> createState() => _ItemsEnStockColumnState();
}

class _ItemsEnStockColumnState extends State<ItemsEnStockColumn> {
  List<ItemsEnStockColumnItem> items = []; // Liste pour afficher les éléments
  Future<Gerant?>? futureGerant;
  Gerant? gerant;

  @override
  void initState() {
    super.initState();
    futureGerant = GerantDataManager.loadStoreData();
    _loadProduits(); // Charger les produits à l'initialisation
  }

  // Méthode pour charger les produits depuis l'entrepôt
  Future<void> _loadProduits() async {
    gerant = await futureGerant;
    // Appel à la méthode pour récupérer les produits de l'entrepôt
    List<ProduitEntrepot>? produits = await GerantRepository()
        .getProduitEntrepot(
            gerant?.gerantentrepot); // Remplacer par le bon nom de l'entrepôt
    if (produits != null) {
      setState(() {
        // Transformer les produits récupérés en `ItemsEnStockColumnItem`
        items = produits.map((produit) {
          return ItemsEnStockColumnItem(
            productType: produit.produit
                .toString(), // Utiliser les champs appropriés de ProduitEntrepot
            quantite: produit.totalquantite.toString(),
            etat: "Bon etat",
            qPlus: 50 ??
                0, // Adapter en fonction des champs existants dans ProduitEntrepot
            qMoins: 50 ?? 0,
          );
        }).toList();
      });
    }
  }

  void _navigateToDetails(String productType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsStocks(productType: productType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      width: MediaQuery.of(context).size.width,
      height: items.isNotEmpty
          ? 200 + items.length * 100
          : 400, // Limite de hauteur, ajustez selon vos besoins
      decoration: BoxDecoration(
        color: teraYellow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: items.isNotEmpty
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(child: items[index]);
              },
            )
          : Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/undraw_empty_cart_co352.png",
                    scale: 5,
                  ),
                  const Text(
                    'Aucun produit en stock',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
