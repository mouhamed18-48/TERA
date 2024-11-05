import 'package:flutter/material.dart';
import 'package:gerant/screens/entrepot/gerer-les-stocks/producteursRow.dart';

class Producteurs extends StatelessWidget {
  const Producteurs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Producteurs",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              "assets/icons/icons8-parametres-90.png",
              scale: 4,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const ProducteursRow(),
      ],
    );
  }
}
