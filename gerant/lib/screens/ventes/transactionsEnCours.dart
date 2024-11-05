import 'package:flutter/material.dart';
import 'package:gerant/screens/ventes/transactionsEnCoursItems.dart';

import '../../constant.dart';

class TransactionsEnCours extends StatelessWidget {
  const TransactionsEnCours({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Transactions en cours",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Row(
                  children: [
                    const Text(
                      "voir tout",
                      style: TextStyle(fontFamily: "Poppins", color: teraOrange),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      "assets/icons/icons8-vers-lavant-90.png",
                      scale: 5,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const TransactionsEnCoursItems(),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                child: Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                      color: teraOrange, borderRadius: BorderRadius.circular(6)),
                  child: const Center(
                    child: Text(
                      "Historique",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: "Poppins"),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
