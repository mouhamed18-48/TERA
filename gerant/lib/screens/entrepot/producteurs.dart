import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerant/screens/entrepot/producteursRow.dart';

import '../../constant.dart';
import 'gerer-les-stocks/stocks.dart';

class Producteurs extends StatelessWidget {
  const Producteurs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/icons/icons8-fermier-homme-90.png",
                  scale: 3,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Producteurs",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
            Image.asset(
              "assets/icons/icons8-chercher-90.png",
              scale: 3,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const ProducteursRow(),
        const SizedBox(
          height: 20,
        ),
        InkWell(
            onTap: () => {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => const Stocks()))
                },
            child: Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                  color: teraOrange, borderRadius: BorderRadius.circular(6)),
              child: const Center(
                child: Text(
                  "Gérer les stocks",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Poppins"),
                ),
              ),
            )),
      ],
    );
  }
}
