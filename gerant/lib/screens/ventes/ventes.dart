import 'package:flutter/material.dart';
import 'package:gerant/screens/ventes/transactionsEnCours.dart';
import 'package:gerant/screens/ventes/ventesEvolutionDesPrix.dart';
import 'package:gerant/screens/ventes/ventesTop.dart';

class Ventes extends StatelessWidget {
  const Ventes({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Column(
              children: [
                const ProduitsDisponibles(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 2,
                  width: 150,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                const VentesEvolutionsDesPrix(),
                const SizedBox(
                  height: 20,
                ),
                const TransactionsEnCours(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
