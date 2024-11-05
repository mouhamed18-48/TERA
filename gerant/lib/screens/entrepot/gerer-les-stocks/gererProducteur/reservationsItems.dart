import 'package:flutter/material.dart';
import 'package:gerant/constant.dart';

import '../../../../repository/gerant_repository.dart';

class ReservationsItems extends StatelessWidget {
  final int? time;
  final String productType;
  final int? quantity;
  final String id;

  const ReservationsItems(
      {super.key,
      required this.time,
      required this.productType,
      required this.quantity,
      required this.id});

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
              "Êtes-vous sûr de bien vouloir marquer la reservation comme terminée ?"),
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
                    await GerantRepository().updateReservationEncours(id, 0);
                if (success) {
                  // Afficher une notification de succès ou mettre à jour l'état de l'application
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: teraOrange,
                      content: Text(
                        "Reservation marquée comme terminée.",
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
                  "assets/icons/icons8-horloge-90.png",
                  scale: 4,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "$time jours restants",
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
                      "Terminer",
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
