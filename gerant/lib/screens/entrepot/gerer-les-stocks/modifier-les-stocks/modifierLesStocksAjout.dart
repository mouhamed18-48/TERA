import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerant/models/Reservation.dart';

import '../../../../constant.dart';
import '../../../../models/Gerant.dart';
import '../../../../models/updateStock.dart';
import '../../../../repository/gerant_repository.dart';
import '../../../../shared_preference/gerant_data_manager.dart';
import '../stocks.dart';


class ModifierLesStocks extends StatefulWidget {
  String? productType;
  ModifierLesStocks({super.key, this.productType});

  @override
  State<ModifierLesStocks> createState() => _ModifierLesStocksState();
}

class _ModifierLesStocksState extends State<ModifierLesStocks> {
  Future<Gerant?>? futureGerant;
  Gerant? gerant;
  Future<String>? futureEntrepotId;
  String? entrepotID;
  int? stayDuration ;
  int? quantity;
  bool isPositive = true;
  TextEditingController produitController = TextEditingController();
  TextEditingController producteurController = TextEditingController();
  TextEditingController raisonController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  final WidgetStateProperty<Icon?> thumbIcon =
  WidgetStateProperty.resolveWith<Icon?>(
        (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.add);
      }
      return const Icon(Icons.remove);
    },
  );

  @override
  void initState() {
    super.initState();
    futureGerant = GerantDataManager.loadStoreData();
    _initClass();
  }
  Future<void> _initClass() async {
    gerant = await futureGerant;
    setState(() {}); // Rebuild after loading data
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () => {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Stocks()))
                      },
                      child: Image.asset(
                        'assets/icons/icons8-fleche-gauche-90.png',
                        scale: 3,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Modification des Stocks",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Sélectionnez un produit",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: teraGrey, borderRadius: BorderRadius.circular(5)),
                    child: DropdownMenu(
                      initialSelection: widget.productType,
                      menuStyle: const MenuStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        fixedSize: WidgetStatePropertyAll(Size(50, 250)),
                      ),
                      width: MediaQuery.of(context).size.width,
                      dropdownMenuEntries: listeProduitDropdown,
                      controller: produitController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Sélectionnez une quantité",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                    Switch(
                    activeColor: teraDarkOrange,
                    thumbIcon: thumbIcon,
                    value: isPositive,
                    onChanged: (bool value) {
                      setState(() {
                        isPositive = value;
                      });
                      print(isPositive);
                    },
                  ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          color: teraGrey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              quantity = int.tryParse(value) ?? 1;
                            });
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Kg",
                        style: TextStyle(fontFamily: "Poppins", fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Numéro du producteur",
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
                      decoration: BoxDecoration(
                          color: teraGrey,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: TextField(
                        controller: producteurController,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Durée de la réservation",
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
                      decoration: BoxDecoration(
                          color: teraGrey,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: TextField(
                        controller: durationController,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Pourquoi modifiez vous le stock?",
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
                    decoration: BoxDecoration(
                        color: teraGrey, borderRadius: BorderRadius.circular(5)),
                    child: DropdownMenu(
                      dropdownMenuEntries: listeRaison,
                      controller: raisonController,
                      width: MediaQuery.of(context).size.width,
                      menuStyle: const MenuStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.white)),
                      menuHeight: 250,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Détails sur la modification?",
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
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: teraGrey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      controller: detailsController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      futureEntrepotId = GerantRepository().getEntrepotIdByName(gerant?.gerantentrepot);
                      entrepotID = await futureEntrepotId;
                      if(isPositive){
                        Reservation reservation = Reservation(
                          resentrepot: entrepotID,
                          reservationduree: int.parse(durationController.text),
                          resproducteur: producteurController.text,
                          resproduit: produitController.text,
                          resquantite:quantity ,
                          resdatetimevalidation: DateTime.now(),
                          livraison: 1,
                          estdeposer: 0,
                          encours: 1,
                        );
                        await GerantRepository().ajoutStock(reservation);
                        Navigator.pop(context,
                            CupertinoPageRoute(builder: (context) => const Stocks()));
                      }else{
                        Update update = Update(
                            resquantite: quantity,
                            resproduit: produitController.text,
                            resproducteur: producteurController.text,
                            resentrepot: entrepotID
                        );
                        await GerantRepository().ModifStock(update);
                        Navigator.pop(context,
                            CupertinoPageRoute(builder: (context) => const Stocks()));
                      }
                    },
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            color: teraOrange,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Text(
                            "Valider",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}





