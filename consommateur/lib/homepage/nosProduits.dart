import 'package:consommateur/homepage/achat/achat.dart';
import 'package:consommateur/repository/consommateur_repository.dart';
import 'package:flutter/material.dart';
import 'package:consommateur/constant.dart';
import '../models/ProduitDispo.dart';

class NosProduits extends StatefulWidget {
  const NosProduits({super.key});

  @override
  State<NosProduits> createState() => _NosProduitsState();
}

class _NosProduitsState extends State<NosProduits> {
  Future<List<ProduitDispo>?>? futureProduitDispo;
  List<ProduitDispo>? produitList;

  @override
  void initState() {
    super.initState();
    _loadEntrepot();
  }

  Future<void> _loadEntrepot() async {
    futureProduitDispo = ConsommateurRepository().getProduit();
    futureProduitDispo?.then((produits) {
      setState(() {
        produitList = produits ?? [];
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: produitList != null && produitList!.isNotEmpty
          ? produitList!.map((produit) {
        return NosProduitsItem(productType: produit.produitType.toString(), name: produit.produitType.toString(), price: produit.produitPrix, quantite: produit.quantite);
      }).toList()
          : [
        Text(
          'Aucune Produit disponible',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: "Poppins",
          ),
        ),
      ],
    );
  }
}

class NosProduitsItem extends StatefulWidget {
  final String productType;
  final String name;
  final int? price;
  final int? quantite;

  const NosProduitsItem({super.key, required this.productType, required this.name, required this.price, required this.quantite});

  @override
  State<NosProduitsItem> createState() => _NosProduitsItemState();
}

class _NosProduitsItemState extends State<NosProduitsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 20, 10),
      padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
      width: Responsive().width(context, 1.2),
      height: 80,
      decoration: BoxDecoration(
        color: teraOrange,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: teraDarkOrange,
                    width: 5
                  )
                ),
                child: ImageProduct(itemType: widget.productType, imageScale: 17,),
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Text("${widget.name}", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),
                  Text("${widget.quantite} kg Disponible", style: TextStyle(fontFamily: "Poppins", fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),),
                  Text("${widget.price} F/kg", style: TextStyle(fontFamily: "Poppins", fontSize: 12, fontWeight: FontWeight.w700),),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Achat(name: widget.name, productType: widget.productType,)));},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: teraDark,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Center(child: Text("Acheter", style: TextStyle(fontFamily: "Poppins", color: Colors.white, fontWeight: FontWeight.bold),)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}