import "package:flutter/material.dart";

import "../../constant.dart";
import "../../models/EntrepotLivraison.dart";
import "../../models/Gerant.dart";
import "../../repository/gerant_repository.dart";
import "../../shared_preference/gerant_data_manager.dart";

class LivraisonsRow extends StatefulWidget {
  const LivraisonsRow({super.key});

  @override
  State<LivraisonsRow> createState() => _LivraisonsRowState();
}

class _LivraisonsRowState extends State<LivraisonsRow> {
  Future<List<Entrepotlivraison>?>? futureLivraisons;
  List<Entrepotlivraison>? Livraisons;
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
    futureLivraisons =
        GerantRepository().getDemandeEntrepotLivraison(gerant?.gerantentrepot);
    futureLivraisons?.then((livraison) {
      setState(() {
        Livraisons =
            livraison ?? []; // Initialement, tous les entrepôts sont affichés
      });
    });

    setState(() {}); // Rebuild after loading data
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: 350,
      height: 130,
      decoration: BoxDecoration(
          color: Livraisons != null && Livraisons!.isNotEmpty
              ? teraDark
              : Colors.white),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Livraisons != null && Livraisons!.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: Livraisons!.map((livraison) {
                    // Utilisation dynamique de la liste Livraisons pour créer les Items
                    return Livraison(
                      name:
                          "${livraison.producterfirstname} ${livraison.productersecondname}",
                      itemType: "${livraison.resproduit}",
                      quantity: livraison.quantitereservation,
                      phone: livraison.resphone.toString(),
                    );
                  }).toList(),
                ))
            : Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/undraw_On_the_way_re_swjt.png",
                      scale: 5,
                    ),
                    const Text(
                      'Aucune livraison en cours', // Message lorsque la liste est vide
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class Livraison extends StatelessWidget {
  final String name;
  final String itemType;
  final String phone;
  final double? quantity;
  String path;

  Livraison(
      {super.key,
      required this.name,
      required this.itemType,
      required this.quantity,
      required this.phone,
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

    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      width: 150,
      height: 110,
      decoration: BoxDecoration(
          color: teraOrange, borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Text(
            phone,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Container(
            width: 130,
            height: 30,
            decoration: const BoxDecoration(
              color: teraDark,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  path,
                  scale: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "$quantity Kg",
                  style: const TextStyle(
                      fontFamily: "Poppins", fontSize: 15, color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
