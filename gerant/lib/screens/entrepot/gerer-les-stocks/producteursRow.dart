import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerant/screens/entrepot/gerer-les-stocks/gererProducteur/gererProducteur.dart';

import '../../../constant.dart';
import '../../../models/Gerant.dart';
import '../../../models/ProducerReservation.dart';
import '../../../repository/gerant_repository.dart';
import '../../../shared_preference/gerant_data_manager.dart';

class ProducteursRow extends StatefulWidget {
  const ProducteursRow({super.key});

  @override
  State<ProducteursRow> createState() => _ProducteursRowState();
}

class _ProducteursRowState extends State<ProducteursRow> {
  Future<List<Producerreservation>?>? futureProducteurs;
  List<Producerreservation>? producteurs;
  Future<Gerant?>? futureGerant;
  Gerant? gerant;

  @override
  void initState() {
    super.initState();
    futureGerant = GerantDataManager.loadStoreData();
    _loadProducteurs();
  }

  Future<void> _loadProducteurs() async {
    gerant = await futureGerant;
    // Appelez la méthode qui récupère la liste des producteurs avec leurs livraisons en cours
    futureProducteurs = GerantRepository().getNumberProducteurReservation(
        gerant?.gerantentrepot); // Assurez-vous que cette méthode existe
    futureProducteurs?.then((producteursList) {
      setState(() {
        producteurs = producteursList ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: producteurs != null && producteurs!.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: producteurs!.map((producteur) {
                  return ProducteursItem(
                      name: "${producteur.firstname} ${producteur.secondname}",
                      nombreLivraison: producteur.reservationsencours,
                      phone: producteur.phone,
                      entrepot: gerant?.gerantentrepot);
                }).toList()))
            : Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/undraw_farm_girl_dnpe.png",
                      scale: 5,
                    ),
                    const Text("Aucun producteur disponible")
                  ],
                ),
              ));
  }
}

class ProducteursItem extends StatelessWidget {
  final String name;
  final int? nombreLivraison;
  final String? phone;
  final String? entrepot;

  const ProducteursItem(
      {super.key,
      required this.name,
      required this.nombreLivraison,
      required this.phone,
      required this.entrepot});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: () => {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => GererProducteur(
                      name: name,
                      phone: phone.toString(),
                      entrepotName: entrepot.toString()))),
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: 130,
          height: 190,
          decoration: BoxDecoration(
              color: teraDark, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: 100,
                decoration: BoxDecoration(
                    color: teraOrange, borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$phone",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Image.asset(
                "assets/icons/icons8-livraison-90.png",
                scale: 2,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "$nombreLivraison en cours",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "Poppins", fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
