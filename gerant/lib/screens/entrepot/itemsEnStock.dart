import 'package:flutter/material.dart';

import '../../constant.dart';
import 'itemsEnStockColumn.dart';

class ItemsEnStockCol extends StatelessWidget {
  const ItemsEnStockCol({super.key});

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
                  "assets/icons/icons8-colis-ouvert-90.png",
                  scale: 3,
                  color: teraOrange,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Items en stock",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const ItemsEnStockColumn(),
      ],
    );
  }
}
