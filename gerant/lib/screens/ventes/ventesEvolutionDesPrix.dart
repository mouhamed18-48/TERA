import 'package:flutter/material.dart';
import 'package:gerant/screens/ventes/ventesEvolutionDesPrixItems.dart';

class VentesEvolutionsDesPrix extends StatelessWidget {
  const VentesEvolutionsDesPrix({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Evolution des prix",
            style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          VentesEvolutionsDesPrixItem(),
        ],
      ),
    );
  }
}
