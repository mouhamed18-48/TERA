import 'package:consommateur/homepage/achatEnCours/AchatEnCours.dart';
import 'package:flutter/material.dart';

import '../../../models/Ventes.dart';
import '../../../models/consommateur.dart';
import '../../../repository/consommateur_repository.dart';
import '../../../shared_preferences/consommateur_data_manager.dart';

class HistoriqueDesAchats extends StatefulWidget {
  const HistoriqueDesAchats({super.key});

  @override
  State<HistoriqueDesAchats> createState() => _HistoriqueDesAchatsState();
}

class _HistoriqueDesAchatsState extends State<HistoriqueDesAchats> {
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
    futureVenteEnCour = ConsommateurRepository().getVentePasEncour(consommateur?.consommateurphone);
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                          onTap: (){
                            Navigator.pop(context,MaterialPageRoute(builder: (context) => AchatEnCours()));
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
                        SizedBox()
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  children: VenteEnCour != null && VenteEnCour!.isNotEmpty
                      ? VenteEnCour!.map((vente) {
                    return AchatsEnCoursItem(productType: vente.venteProduit.toString(), name: vente.venteProduit.toString(), price: vente.ventePrix!.toInt(), weight: vente.venteQuantite!.toString(), label: "Il y a ${vente.tempsLivraison.toString()} jours",);
                  }).toList()
                      : [
                    Center(
                      child: Text(
                        'Aucune vente en historique',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
      );
  }
}