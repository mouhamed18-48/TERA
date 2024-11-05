import "package:flutter/material.dart";

import "itemRow.dart";

class ItemsEnStock extends StatelessWidget {
  const ItemsEnStock({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Items en stock",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ItemRow(),
      ],
    );
  }
}
