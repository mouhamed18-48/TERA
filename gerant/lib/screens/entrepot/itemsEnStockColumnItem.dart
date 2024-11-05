import 'package:flutter/material.dart';

import '../../constant.dart';
import 'detailsStocks.dart';

class ItemsEnStockColumnItem extends StatefulWidget {
  final String productType;
  final String quantite;
  final String etat;
  final int qPlus;
  final int qMoins;

  const ItemsEnStockColumnItem({
    super.key,
    required this.productType,
    required this.quantite,
    required this.etat,
    required this.qPlus,
    required this.qMoins,
  });

  @override
  State<ItemsEnStockColumnItem> createState() => _ItemsEnStockColumnItemState();
}

class _ItemsEnStockColumnItemState extends State<ItemsEnStockColumnItem> {
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    if (widget.productType == "carotte") {
      imagePath = "assets/les-carottes.png";
    }
    if (widget.productType == "patate") {
      imagePath = "assets/patate.png";
    }
    if (widget.productType == "cacahuete") {
      imagePath = "assets/cacahuete.png";
    }
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return DetailsStocks(productType: widget.productType);
            });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        width: 300,
        height: 80,
        color: teraDarkYellow,
        child: Row(
          children: [
            Stack(
              alignment: const AlignmentDirectional(1, 1.5),
              children: [
                Image.asset(
                  imagePath!,
                  scale: 10,
                ),
                Image.asset(
                  "assets/icons/icons8-plus-90.png",
                  scale: 5,
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 2,
              height: 80,
              color: teraYellow,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/icons8-poids-90.png",
                      scale: 4,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${widget.quantite} Kg",
                      style: const TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/icons8-coeur-en-bonne-sante-90.png",
                      scale: 4,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.etat,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                  ],
                ),
              ],
            ),
              const SizedBox(
                width: 30,
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/icons8-fleche-bas-90.png",
                      scale: 4,
                    ),
                    Text(
                      "+${widget.qPlus} Kg",
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          color: Color.fromARGB(255, 72, 116, 44)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/icons8-fleche-haut-90.png",
                      scale: 4,
                    ),
                    Text(
                      "-${widget.qMoins} Kg",
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          color: Color.fromARGB(255, 140, 26, 17)),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
