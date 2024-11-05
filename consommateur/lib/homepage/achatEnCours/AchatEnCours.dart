import 'package:consommateur/homepage/achatEnCours/historique/historiqueDesAchats.dart';
import 'package:consommateur/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:consommateur/constant.dart';

import '../../models/Ventes.dart';
import '../../models/consommateur.dart';
import '../../repository/consommateur_repository.dart';
import '../../shared_preferences/consommateur_data_manager.dart';

class AchatEnCours extends StatefulWidget {
  const AchatEnCours({super.key});

  @override
  State<AchatEnCours> createState() => _AchatEnCoursState();
}

class _AchatEnCoursState extends State<AchatEnCours> {
  Future<List<Ventes>?>? futureVenteEnCour;
  List<Ventes>? VenteEnCour;
  Future<Consommateur?>? futureConsommateur;
  Consommateur? consommateur;

  @override
  void initState() {
    super.initState();
    futureConsommateur = ConsommateurDataManager.loadStoreData();
    _loadVentesEnCours();
  }

  Future<void> _loadVentesEnCours() async {
    consommateur = await futureConsommateur;
    setState(() {});
    futureVenteEnCour = ConsommateurRepository().getVenteEncour(consommateur?.consommateurphone);
    futureVenteEnCour?.then((ventes) {
      setState(() {
        VenteEnCour = ventes ?? [];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context,MaterialPageRoute(builder: (context) => Homepage()));
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Image.asset("assets/icons/icons8-fleche-gauche-90.png", scale: 3,),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Mes achats en cours", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(height: 20,),
                  Container(
                    width: Responsive().width(context, 1),
                    height: Responsive().height(context, 1.5),
                    child: SingleChildScrollView(
                      child: Column(
                        children: VenteEnCour != null && VenteEnCour!.isNotEmpty
                            ? VenteEnCour!.map((vente) {
                          return AchatsEnCoursItem(productType: vente.venteProduit.toString(), name: vente.venteProduit.toString(), price: vente.ventePrix!.toInt(), weight: vente.venteQuantite!.toString(), label: "Dans ${vente.tempsLivraison.toString()} jours",);
                        }).toList()
                            : [
                          Center(
                            child: Text(
                              'Aucune vente en cours',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: Container(
                      width: 150,
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: InkWell(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (builder)=> HistoriqueDesAchats()));},
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          color: teraOrange,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(child: Text("Historique", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),)),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ));
  }
}

class AchatsEnCoursItem extends StatefulWidget {
  final String productType;
  final String name;
  final int price;
  final String label;
  final String weight;

  const AchatsEnCoursItem({super.key, required this.productType, required this.name, required this.price, required this.label, required this.weight});

  @override
  State<AchatsEnCoursItem> createState() => _NosProduitsItemState();
}

class _NosProduitsItemState extends State<AchatsEnCoursItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          width: Responsive().width(context, 1.2),
          height: 80,
          decoration: BoxDecoration(
            color: teraDark,
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
                        color: Colors.black,
                        width: 5
                      )
                    ),
                    child: ImageProduct(itemType: widget.productType, imageScale: 17,),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      Text("${widget.name}", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Image.asset("assets/icons/icons8-poids-90-orange.png", scale: 5,),
                          SizedBox(width: 5,),
                          Text("${widget.weight} Kg", style: TextStyle(fontFamily: "Poppins", fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: teraOrange,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Text("${widget.price}", style: TextStyle(fontFamily: "Poppins", color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(width: 5,),
                      Text("Fcfa", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, color: Colors.white),),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}