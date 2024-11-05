import 'package:flutter/material.dart';
import 'package:gerant/constant.dart';

import '../../../repository/gerant_repository.dart';

class ReservationsFiniItems extends StatelessWidget {
  final String name;
  final String productType;
  final double? quantity;
  final String id;
  final String phone;

  const ReservationsFiniItems({
    super.key,
    required this.name,
    required this.productType,
    required this.quantity,
    required this.id,
    required this.phone
    });


  // Méthode pour afficher le dialogue de confirmation
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Confirmation",style: TextStyle(color: Colors.black),),
          content: Text(
              style: TextStyle(color: Colors.black),
              "Êtes-vous sûr de bien vouloir marquer la reservation comme terminée ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le dialogue
              },
              child: Text(
                "Non",
                style: TextStyle(color: teraOrange),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Fermer le dialogue
                bool success = await GerantRepository().updateReservationEncours(id, 0);
                if (success) {
                  // Afficher une notification de succès ou mettre à jour l'état de l'application
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: teraOrange,
                      content: Text("Reservation marquée comme terminée.", style: TextStyle(color: Colors.white),),
                    ),
                  );
                } else {
                  // Gérer les erreurs
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: teraOrange,
                      content: Text("Erreur lors de la mise à jour.", style: TextStyle(color: Colors.white),),
                    ),
                  );
                }
              },
              child: Text(
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100)
              ),
              child: Center(
                child: Image.asset("assets/icons/mini-user.png", scale: 3,)
              ),
            ),
            SizedBox(width: 10,),
            Text(name, style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16),),
            SizedBox(width: 10,),
            Text(phone, style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16),)
            ],
        ),
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/icons/icons8-horloge-90.png", scale: 4,),
                      SizedBox(width: 10,),
                      Text("Aujourd'hui", style: TextStyle(fontFamily: "Poppins", fontSize: 14),)
                    ]
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      ImageProduct(itemType: "patate", imageScale: 20,),
                      SizedBox(width: 10,),
                      Text("$quantity Kg", style: TextStyle(fontFamily: "Poppins", fontSize: 14),)
                    ]
                  ),
                ],
              ),
              Container(
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                  color: teraOrange,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(5),
                    bottomEnd: Radius.circular(5)
                  )
                ),
                child: Center(
                  child: InkWell(
                    onTap: () => _showConfirmationDialog(context),
                    child: Container(
                      width: 90,
                      height: 60,
                      color: teraDarkOrange,
                      child: Center(
                        child: Text(
                          "Terminer",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14
                          ),
                          ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}