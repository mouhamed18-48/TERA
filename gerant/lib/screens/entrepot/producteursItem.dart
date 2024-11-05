import 'package:flutter/material.dart';
import '../../constant.dart';

class ProducteursItem extends StatefulWidget {
  final String name;
  final List<ProductItem> listeItems;

  const ProducteursItem({
    super.key,
    required this.name,
    required this.listeItems,
  });

  @override
  State<ProducteursItem> createState() => _ProducteursItemState();
}

class _ProducteursItemState extends State<ProducteursItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      padding: const EdgeInsets.all(10),
      width: 130,
      height: 240, // Hauteur définie pour limiter l'espace vertical
      decoration: BoxDecoration(
        color: teraDark,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 90,
              height: 50,
              decoration: BoxDecoration(
                color: teraOrange,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Produits (${widget.listeItems.length})",
            style: const TextStyle(
              fontFamily: "Poppins",
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          // Utilisation de Expanded avec ListView pour le défilement vertical
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: widget.listeItems,
              ),
            ),
          ),
        ],
      ),
    );
  }
}





class ProductItem extends StatelessWidget {

  final String productType;
  final String quantity;
    String imagePath;
   ProductItem({
    super.key,
    required this.productType,
    required this.quantity,
    this. imagePath = ""
    });

  @override
  Widget build(BuildContext context) {
    if(productType == "carotte"){
      imagePath = "assets/les-carottes.png";
    }
    if(productType == "patate"){
      imagePath = "assets/patate.png";
    }
    if(productType == "cacahuete"){
      imagePath = "assets/cacahuete.png";
    }
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Row(
        children: [
          Image.asset(imagePath, scale: 24,),
          SizedBox(width: 10,),
          Text("$quantity Kg", style: TextStyle(fontFamily: "Poppins", color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),),
        ],
      ),
    );
  }
}
