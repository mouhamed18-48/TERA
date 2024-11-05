import 'package:flutter/material.dart';

import '../../models/EntrepotCapacityByName.dart';
import '../../models/Gerant.dart';
import '../../repository/gerant_repository.dart';
import '../../shared_preference/gerant_data_manager.dart';

class TopTitle extends StatefulWidget {
  const TopTitle({super.key});

  @override
  State<TopTitle> createState() => _TopTitleState();
}

class _TopTitleState extends State<TopTitle> {
  Future<Gerant?>? futureGerant;
  Gerant? gerant;
  Future<Entrepotcapacitybyname?>? futureCapacity;
  Entrepotcapacitybyname? entrepotcapacitybyname;

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

    setState(() {}); // Rebuild after loading data
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Entrepôt de ${gerant?.gerantentrepot}",
          style: const TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "${entrepotcapacitybyname?.entrepotcapacitetotal} Kg d'espace libre",
          style: const TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
