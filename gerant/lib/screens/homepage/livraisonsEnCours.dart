import "package:flutter/material.dart";

import "livraisonsRow.dart";

class LivraisonsEnCours extends StatelessWidget {
  const LivraisonsEnCours({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Demande de livraison",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        LivraisonsRow(),
      ],
    );
  }
}
