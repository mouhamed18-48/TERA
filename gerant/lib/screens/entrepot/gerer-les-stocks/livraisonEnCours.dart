import 'dart:ffi';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../models/EntrepotLivraison.dart';
import '../../../models/Gerant.dart';
import '../../../repository/gerant_repository.dart';
import '../../../shared_preference/gerant_data_manager.dart';

class LivraisonsEnCours extends StatefulWidget {
  const LivraisonsEnCours({super.key});

  @override
  State<LivraisonsEnCours> createState() => _LivraisonsEnCoursState();
}

class _LivraisonsEnCoursState extends State<LivraisonsEnCours> {
  Future<List<Entrepotlivraison>?>? futureLivraisons;
  List<Entrepotlivraison>? livraisons;
  Future<Gerant?>? futureGerant;
  Gerant? gerant;

  @override
  void initState() {
    super.initState();
    futureGerant = GerantDataManager.loadStoreData();
    _loadLivraisons();
  }

  Future<void> _loadLivraisons() async {
    gerant = await futureGerant;
    futureLivraisons =
        GerantRepository().getEntrepotLivraison(gerant?.gerantentrepot);
    futureLivraisons?.then((livraisonList) {
      setState(() {
        livraisons = livraisonList ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Livraisons en cours (${livraisons?.length ?? 0})",
          style: const TextStyle(
              fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: 230,
            color: teraGrey,
            child: SingleChildScrollView(
              child: Column(
                children: livraisons != null && livraisons!.isNotEmpty
                    ? livraisons!.map((livraison) {
                        return Livraisons(
                          name: "${livraison.producterfirstname}",
                          productType: "${livraison.resproduit}",
                          quantity: livraison.quantitereservation?.toInt() ?? 0,
                          id: livraison.resid.toString(),
                        );
                      }).toList()
                    : [
                        Column(
                          children: [
                            Image.asset("assets/undraw_On_the_way_re_swjt -2.png"),
                            const Text(
                              'Aucune livraison en cours',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Livraisons extends StatelessWidget {
  final String name;
  final String productType;
  final int quantity;
  final String id;

  const Livraisons({
    super.key,
    required this.name,
    required this.productType,
    required this.quantity,
    required this.id,
  });

  // Méthode pour afficher le dialogue de confirmation
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Confirmation",
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
              style: TextStyle(color: Colors.black),
              "Êtes-vous sûr de bien vouloir marquer la livraison comme complète ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le dialogue
              },
              child: const Text(
                "Non",
                style: TextStyle(color: teraOrange),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Fermer le dialogue
                bool success =
                    await GerantRepository().updateReservationLivrer(id, 1);
                if (success) {
                  // Afficher une notification de succès ou mettre à jour l'état de l'application
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: teraOrange,
                      content: Text(
                        "Livraison marquée comme complète.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                } else {
                  // Gérer les erreurs
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: teraOrange,
                      content: Text(
                        "Erreur lors de la mise à jour.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                "Oui",
                style: TextStyle(color: teraOrange),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Image.asset(
                  "assets/icons/icons8-utilisateur-sexe-neutre-90.png",
                  scale: 4,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  name,
                  style: const TextStyle(fontFamily: "Poppins", fontSize: 14),
                )
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                ImageProduct(
                  itemType: productType,
                  imageScale: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "$quantity Kg",
                  style: const TextStyle(fontFamily: "Poppins", fontSize: 14),
                )
              ]),
            ],
          ),
          Container(
            width: 120,
            height: 80,
            decoration: const BoxDecoration(
                color: teraOrange,
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(5), bottomEnd: Radius.circular(5))),
            child: Center(
              child: InkWell(
                onTap: () => _showConfirmationDialog(context),
                child: Container(
                  width: 90,
                  height: 60,
                  color: teraDarkOrange,
                  child: const Center(
                    child: Text(
                      "Confirmer l'arrivée",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
