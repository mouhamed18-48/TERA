import 'package:consommateur/homepage/homepage.dart';
import 'package:consommateur/models/Vente.dart';
import 'package:consommateur/repository/consommateur_repository.dart';
import 'package:flutter/material.dart';
import 'package:consommateur/constant.dart';

import '../../models/ProduitDispo.dart';
import '../../models/consommateur.dart';
import '../../shared_preferences/consommateur_data_manager.dart';


class Achat extends StatefulWidget {
  final String name;
  final String productType;
  const Achat({super.key, required this.name, required this.productType});

  @override
  State<Achat> createState() => _AchatState();
}

class _AchatState extends State<Achat> {
  List<ProduitDispo>? ProduitInfos;
  Future<List<ProduitDispo>?>? futureProduitInfos;
  int totalAmount = 0;
  int quantity = 1;
  String adresse = '';
  String numero = '';
  String facturation = '';
  Future<Consommateur?>? futureConsommateur;
  Consommateur? consommateur;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureConsommateur = ConsommateurDataManager.loadStoreData();
    futureProduitInfos = ConsommateurRepository().getProduitsInfo();
    _initClass();
    futureProduitInfos?.then((produitInformations) {
      setState(() {
        ProduitInfos = produitInformations ?? []; // Initialement, tous les entrepôts sont affichés
      });
    });
  }
  Future<void> _initClass() async{
    consommateur = await futureConsommateur;
    setState(() {});
  }

  void calculateTotal(List<ProduitDispo> produitInfos, String nom, int quantity) {
    int? price;

    for (ProduitDispo produit in produitInfos) {
      if (produit.produitType == nom) {
        price= produit.produitPrix; // Retourne le tarif si le nom correspond
      }
    }

    // Calculer le total
    totalAmount = (price! * quantity) ;
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: teraDark,
                              borderRadius: BorderRadius.circular(70)
                          ),
                          child: ImageProduct(itemType: widget.productType, imageScale: 10,),

                        ),
                        SizedBox(height: 10,),
                        Text(widget.name, style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 18),),
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Quantité", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 14),),
                      SizedBox(height: 10,),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: teraGrey,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: TextField(
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                )
                            ),
                            onChanged: (value){
                              setState(() {
                                quantity = int.tryParse(value) ?? 1;
                                calculateTotal(ProduitInfos!, widget.name, quantity!);
                              });
                            },
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Adresse de livraison', style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 14),),
                      SizedBox(height: 10,),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: teraGrey,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                )
                            ),
                            onChanged: (value){
                              setState(() {
                                adresse = value.toString();
                              });
                            },
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Numéro de livraison', style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 14),),
                      SizedBox(height: 10,),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: teraGrey,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                )
                            ),
                            onChanged: (value){
                              setState(() {
                                numero = value.toString();
                              });
                            },
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text("Option de paiement", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 14),),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                        color: teraGrey,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: DropdownMenu(
                      menuStyle: MenuStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        fixedSize: WidgetStatePropertyAll(Size(50, 250)),
                      ),
                      width: MediaQuery.of(context).size.width,
                      dropdownMenuEntries: listePaiement,

                    ),
                  ),

                  SizedBox(height: 20,),
                  Text("Total: $totalAmount", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(height: 20,),
                  Center(
                    child: InkWell(
                      onTap: () async{
                        Vente vente = Vente(
                          venteConsommateur: consommateur?.consommateurphone,
                          venteProduit: widget.name,
                          venteEncour: 1,
                          ventePrix: totalAmount,
                          venteQuantite: quantity,
                          venteDatetimeValidation: DateTime.now(),
                          addresse: adresse.toString(),
                          numero: numero.toString()
                        );
                        await ConsommateurRepository().createVente(vente);
                        Navigator.pop(context, MaterialPageRoute(builder: (builder) => Homepage()));
                        },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: teraOrange
                        ),
                        child: Center(child:Text(
                          "Acheter",
                          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}





class TeraTexfield2 extends StatefulWidget {
  final String title;
  const TeraTexfield2({super.key, required this.title});


  @override
  State<TeraTexfield2> createState() => _TeraTexfield2State();
}

class _TeraTexfield2State extends State<TeraTexfield2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 14),),
        SizedBox(height: 10,),
        Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: teraGrey,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey)
            ),
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )
              ),

            )
        )
      ],
    );
  }
}


