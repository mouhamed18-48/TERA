import "package:flutter/material.dart";
import "package:gerant/screens/homepage/reservationbientotfini/reservationsBientotFini.dart";

import "../../constant.dart";
import "../../models/EntrepotCapacityByName.dart";
import "../../models/Gerant.dart";
import "../../models/NumberReservationExpiredIn7Day.dart";
import "../../repository/gerant_repository.dart";
import "../../shared_preference/gerant_data_manager.dart";

class Top extends StatefulWidget {
  const Top({super.key});

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  Future<Gerant?>? futureGerant;
  Gerant? gerant;
  Future<Entrepotcapacitybyname?>? futureCapacity;
  Entrepotcapacitybyname? entrepotcapacitybyname;
  Future<Numberreservationexpiredin7day?>? futureNumber;
  Numberreservationexpiredin7day? numberreservationexpiredin7day;
  @override
  void initState() {
    super.initState();
    futureGerant = GerantDataManager.loadStoreData();
    _initClass();
  }

  Future<void> _initClass() async {
    gerant = await futureGerant;
    futureCapacity =
        GerantRepository().getEntrepotCapacityByName(gerant?.gerantentrepot);
    futureCapacity?.then((capacity) {
      setState(() {
        entrepotcapacitybyname = capacity ??
            Entrepotcapacitybyname(); // Initialement, tous les entrepôts sont affichés
      });
    });
    futureNumber = GerantRepository()
        .getNumberReservationExpiredIn7Day(gerant?.gerantentrepot);
    futureNumber?.then((number) {
      setState(() {
        numberreservationexpiredin7day = number ??
            Numberreservationexpiredin7day(); // Initialement, tous les entrepôts sont affichés
      });
    });

    setState(() {}); // Rebuild after loading data
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 190,
        decoration: const BoxDecoration(
            color: teraOrange,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(47),
              bottomRight: Radius.circular(47),
            )),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/Tera2.png",
                    scale: 10,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Entrepôt de ${gerant?.gerantentrepot}",
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width / 1.2,
              height: 90,
              decoration: BoxDecoration(
                  color: teraDarkOrange,
                  borderRadius: BorderRadius.circular(22)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TopInfo(
                          content:
                              "${entrepotcapacitybyname?.entrepotcapacitetotal} Kg d'espace libre",
                          iconPath: "assets/icons/icons8-entrepot-90.png"),
                      Image.asset(
                        "assets/icons/icons8-fleche-droite-90.png",
                        scale: 4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ReservationsBientotFini())),
                              },
                          child: TopInfo(
                              content:
                                  "${numberreservationexpiredin7day?.nreservationsexpiring_today ?? 0} stocks finissent aujourd'hui",
                              iconPath: "assets/icons/icons8-expire-90.png")),
                      Image.asset(
                        "assets/icons/icons8-fleche-droite-90.png",
                        scale: 4,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopInfo extends StatefulWidget {
  final String content;
  final String iconPath;

  const TopInfo({
    super.key,
    required this.content,
    required this.iconPath,
  });

  @override
  State<TopInfo> createState() => _TopInfoState();
}

class _TopInfoState extends State<TopInfo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          widget.iconPath,
          scale: 4,
          color: Colors.white,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          widget.content,
          style: const TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              color: Colors.white),
        )
      ],
    );
  }
}
