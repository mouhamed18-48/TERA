import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../models/Gerant.dart';
import '../../repository/gerant_repository.dart';
import '../../shared_preference/gerant_data_manager.dart';

class ItemRow extends StatefulWidget {
  const ItemRow({super.key});

  @override
  State<ItemRow> createState() => _ItemRowState();
}

class _ItemRowState extends State<ItemRow> {
  Future<List<String>?>? futureProduit;
  List<String>? produits;
  Future<Gerant?>? futureGerant;
  Gerant? gerant;

  @override
  void initState() {
    super.initState();
    futureGerant = GerantDataManager.loadStoreData();
    _initClass();
  }

  Future<void> _initClass() async {
    gerant = await futureGerant;
    futureProduit =
        GerantRepository().getDistinctProductTypes(gerant?.gerantentrepot);
    futureProduit?.then((produit) {
      setState(() {
        produits =
            produit ?? []; // Initialement, tous les entrepôts sont affichés
      });
    });

    setState(() {}); // Rebuild after loading data
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      width: MediaQuery.of(context).size.width / 1.2,
      height: produits != null && produits!.isNotEmpty ? 80 : 150,
      decoration: BoxDecoration(
          color: produits != null && produits!.isNotEmpty
              ? teraGrey
              : Colors.white),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: produits != null
            ? (produits!.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: produits!.map((produit) {
                        // Utilisation dynamique de la liste produits pour créer les Items
                        return Item(
                          itemType: produit,
                          itemInfo: Container(),
                        );
                      }).toList(),
                    ))
                : Center(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/undraw_empty_cart_co35.png",
                          scale: 7,
                        ),
                        const Text(
                          'Aucun produit disponible', // Message lorsque la liste est vide
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ))
            : const Center(
                child: Text(
                  'Chargement...', // Message de chargement
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String itemType;
  final Widget itemInfo;
  String path;

  Item(
      {super.key,
      required this.itemType,
      required this.itemInfo,
      this.path = ""});

  @override
  Widget build(BuildContext context) {
    if (itemType == "carotte") {
      path = "assets/les-carottes.png";
    }
    if (itemType == "patate") {
      path = "assets/patate.png";
    }
    if (itemType == "cacahuete") {
      path = "assets/cacahuete.png";
    }
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: teraDark,
        ),
        child: Image.asset(
          path,
          scale: 11,
        ),
      ),
    );
  }
}
