import 'package:flutter/material.dart';
import 'package:producteur/constant.dart';

class ShopCard extends StatefulWidget {
  String? name;
  double? weight;
  double? price;

  ShopCard({super.key, this.name, this.weight, this.price});

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20),
      width: MediaQuery.of(context).size.width > 400
          ? 300
          : MediaQuery.of(context).size.width / 1.4,
      height: 170,
      decoration: BoxDecoration(
          color: teraDark, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    "assets/images/Tera2.png",
                    scale: 9,
                  )),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${widget.name}",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image.asset(
                "assets/icons/poids-icon.png",
                scale: 5,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${widget.weight} kg vendus",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Container(
                width: 150,
                height: 40,
                decoration: const BoxDecoration(
                    color: teraOrange,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Center(
                  child: Text(
                    "${widget.price}f",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
