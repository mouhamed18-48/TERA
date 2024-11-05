import 'package:flutter/material.dart';
import 'package:gerant/constant.dart';
import 'package:gerant/screens/homepage/reservationbientotfini/reservationsFiniItems.dart';

import '../../../models/EntrepotLivraison.dart';
import '../../../models/Gerant.dart';
import '../../../repository/gerant_repository.dart';
import '../../../shared_preference/gerant_data_manager.dart';
import '../../navigationBar.dart';


class ReservationsBientotFini extends StatefulWidget {
  const ReservationsBientotFini({super.key});

  @override
  State<ReservationsBientotFini> createState() => _ReservationsBientotFiniState();
}

class _ReservationsBientotFiniState extends State<ReservationsBientotFini> {
  Future<List<Entrepotlivraison>?>? futureReservation;
  List<Entrepotlivraison>? listeReservations;
  Future<Gerant?>? futureGerant;
  Gerant? gerant;

  @override
  void initState() {
    super.initState();
    futureGerant=GerantDataManager.loadStoreData();
    _initClass();
  }



  Future<void> _initClass() async {
    gerant = await futureGerant;
    futureReservation = GerantRepository().getEntrepotReservationExpiringToday(gerant?.gerantentrepot);
    futureReservation?.then((reservations) {
      setState(() {
        listeReservations = reservations ?? []; // Initialement, tous les entrepôts sont affichés
      });
    });

    setState(() {}); // Rebuild after loading data
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () => {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => NavBar())
                    )
                  },
                  child: Image.asset('assets/icons/icons8-fleche-gauche-90.png', scale: 3,)),
              SizedBox(height: 10,),
              Text("Réservations qui finnissent aujourd'hui", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 40,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/1.3,
                color: teraGrey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: SingleChildScrollView(

                    child: SingleChildScrollView(
                      child: listeReservations != null && listeReservations!.isNotEmpty
                          ? Column(
                        children: listeReservations!.map((livraison) {
                          // Utilisation dynamique de la liste Livraisons pour créer les Items
                          return ReservationsFiniItems(
                            name: "${livraison.producterfirstname.toString()} ${livraison.productersecondname}",
                            productType: livraison.resproduit.toString(),
                            quantity: livraison.quantitereservation,
                            id: livraison.resid.toString(),
                            phone: livraison.resphone.toString()
                          );
                        }).toList(),
                      )
                          : Center(
                        child: Text(
                          "Aucune reservation finie aujourd'hui", // Message lorsque la liste est vide
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}