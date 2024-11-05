import 'package:flutter/material.dart';

import '../../../../constant.dart';
import '../../../../models/EntrepotLivraison.dart';
import '../../../../models/Gerant.dart';
import '../../../../repository/gerant_repository.dart';
import '../../../../shared_preference/gerant_data_manager.dart';
import '../stocks.dart';

class Historique extends StatefulWidget {
  const Historique({super.key});

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  Future<List<Entrepotlivraison>?>? futureHistorique;
  List<Entrepotlivraison>? historique;
  Future<Gerant?>? futureGerant;
  Gerant? gerant;

  @override
  void initState() {
    super.initState();
    futureGerant = GerantDataManager.loadStoreData();
    _loadHistorique();
  }

  Future<void> _loadHistorique() async {
    gerant = await futureGerant;
    futureHistorique = GerantRepository()
        .getEntrepotReservationDeposer(gerant?.gerantentrepot);
    futureHistorique?.then((historiqueList) {
      setState(() {
        historique = historiqueList ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () => {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Stocks()))
                        },
                    child: Image.asset(
                      'assets/icons/icons8-fleche-gauche-90.png',
                      scale: 3,
                    )),
                const SizedBox(height: 10),
                Text(
                  "Historique des livraisons (${historique?.length ?? 0})",
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  width: MediaQuery.of(context).size.width,
                  height: 700,
                  color: historique != null && historique!.isNotEmpty
                      ? teraGrey
                      : Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: historique != null && historique!.isNotEmpty
                          ? historique!.map((livraison) {
                              return LivraisonsHistorique(
                                name:
                                    "${livraison.producterfirstname} ${livraison.productersecondname}",
                                productType: "${livraison.resproduit}",
                                quantity:
                                    livraison.quantitereservation?.toInt() ?? 0,
                                id: livraison.resid.toString(),
                              );
                            }).toList()
                          : [
                              Image.asset(
                                "assets/undraw_Not_found_re_bh2e.png",
                                scale: 1,
                              ),
                              const Text(
                                'Aucune livraison passée',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LivraisonsHistorique extends StatelessWidget {
  final String name;
  final String productType;
  final int quantity;
  final String id;

  const LivraisonsHistorique({
    super.key,
    required this.name,
    required this.productType,
    required this.quantity,
    required this.id,
  });

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Retirer Confirmation",
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
              style: TextStyle(color: Colors.black),
              "Etes vous sûr de bien vouloir marquer la livraison comme incomplète ?"),
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
                    await GerantRepository().updateReservationLivrer(id, 0);
                if (success) {
                  // Afficher une notification de succès ou mettre à jour l'état de l'application
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: teraOrange,
                      content: Text(
                        "Livraison marquée comme incomplète.",
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
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis),
                  ),
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
                      "Retirer Confirmation",
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
