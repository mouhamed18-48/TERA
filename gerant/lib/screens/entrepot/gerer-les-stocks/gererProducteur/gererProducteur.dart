import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerant/constant.dart';
import 'package:gerant/models/reservationProd.dart';
import 'package:gerant/screens/entrepot/gerer-les-stocks/gererProducteur/reservationsItems.dart';
import 'package:gerant/screens/entrepot/gerer-les-stocks/stocks.dart';

import '../../../../repository/gerant_repository.dart';

class GererProducteur extends StatefulWidget {
  final String name;
  final String phone;
  final String entrepotName;
  const GererProducteur(
      {super.key,
      required this.name,
      required this.phone,
      required this.entrepotName});

  @override
  State<GererProducteur> createState() => _GererProducteurState();
}

class _GererProducteurState extends State<GererProducteur> {
  Future<List<reservationProd>?>? futurereservation;
  List<reservationProd>? reservations;

  @override
  void initState() {
    super.initState();
    _loadLivraisons();
  }

  Future<void> _loadLivraisons() async {
    futurereservation = GerantRepository()
        .getEntrepotReservationProducteurEnCour(
            widget.entrepotName, widget.phone);
    futurereservation?.then((reserve) {
      setState(() {
        reservations = reserve ?? [];
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () => {
                        Navigator.pop(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const Stocks()))
                      },
                  child: Image.asset(
                    'assets/icons/icons8-fleche-gauche-90.png',
                    scale: 3,
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(),
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: teraDark,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset(
                          "assets/icons/icons8-utilisateur-sexe-neutre-90.png",
                          scale: 1.5,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.name,
                        maxLines: 2,
                        style: const TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.phone,
                        style: const TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    ],
                  ),
                  const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Réservations",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.7,
                color: teraGrey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: reservations != null && reservations!.isNotEmpty
                          ? reservations!.map((reservation) {
                              return ReservationsItems(
                                productType: reservation.resproduit.toString(),
                                quantity:
                                    reservation.quantitereservation?.toInt(),
                                time: reservation.temps_restant_jours,
                                id: reservation.resid.toString(),
                              );
                            }).toList()
                          : [
                              const Text(
                                'Aucune reservation',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                    ),
                  ),
                ),
              )
            ],
          )),
    ));
  }
}
