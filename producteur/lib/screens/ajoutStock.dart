import 'package:flutter/material.dart';
import 'package:producteur/constant.dart';
import '../functions/function.dart';
import '../models/Producteur.dart';
import '../models/Produit.dart';
import '../models/RegisterReservation.dart';
import '../models/Reservation.dart';
import '../repositories/entrepot_repository.dart';
import '../repositories/produit_repository.dart';
import '../repositories/reservation_repository.dart';
import '../shared_preferences/producteur_data_manager.dart';

void showAddStockOverlay(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AddStockOverlay();
    },
  );
}

class AddStockOverlay extends StatefulWidget {
  const AddStockOverlay({super.key});

  @override
  _AddStockOverlayState createState() => _AddStockOverlayState();
}

class _AddStockOverlayState extends State<AddStockOverlay> {
  String selectedProduct = 'carotte';
  String selectedWarehouse = 'Keur Massar';
  String selectedOperator = 'Orange Money';
  bool isDelivery = false;
  int isDeliveryInt = 0;
  int quantity = 1;
  int stayDuration = 7;
  double totalAmount = 0;
  String phoneNumber = '';
  List<Produit>? ProduitInfos;
  Future<List<Produit>?>? futureProduitInfos;
  int currentStep = 1;
  Producteur? producteur;
  Future<Producteur?>? futureProducter;
  Future<String>? futureEntrepotId;
  String? entrepotID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureProducter = ProducteurDataManager.loadStoreData();
    futureProduitInfos = ProduitRepository().getProduits();
    futureProduitInfos?.then((produitInformations) {
      setState(() {
        ProduitInfos = produitInformations ??
            []; // Initialement, tous les entrepôts sont affichés
      });
    });
    _initClass();
  }

  Future<void> _initClass() async {
    producteur = await futureProducter;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (currentStep == 1) buildProductSelectionStep(),
                if (currentStep == 2) buildPaymentStep(),
                if (currentStep == 3) buildSuccessMessageStep(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateTotal(List<Produit> produitInfos, String nom) {
    // Prix de livraison par jour (exemple)
    double deliveryPricePerDay = isDelivery ? 50.0 : 0.0;
    double? price;

    for (Produit produit in produitInfos) {
      if (produit.produittype == nom) {
        price = produit.produittarif; // Retourne le tarif si le nom correspond
      }
    }

    // Calculer le total
    totalAmount =
        (price! * quantity * stayDuration) + (deliveryPricePerDay * quantity);
  }

  Widget buildProductSelectionStep() {
    return Container(
      color: Colors.white, // Fond blanc
      padding: const EdgeInsets.all(16.0), // Ajout de padding pour l'espacement
      child: Column(
        children: [
          // Product Dropdown
          DropdownButtonFormField<String>(
            value: selectedProduct,
            decoration: const InputDecoration(
              labelText: 'Produit',
              labelStyle: TextStyle(color: Colors.black), // Texte en noir
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Bordure en noir
              ),
            ),
            dropdownColor: Colors.white, // Fond du menu déroulant en blanc
            style: const TextStyle(
                color: Colors.black), // Texte du menu déroulant en noir
            items: const [
              DropdownMenuItem(value: 'carotte', child: Text('carotte')),
              DropdownMenuItem(value: 'cacahuete', child: Text('cacahuete')),
              DropdownMenuItem(value: 'patate', child: Text('patate')),
            ],
            onChanged: (value) {
              setState(() {
                selectedProduct = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          // Quantity Input
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantité (Kg)',
              labelStyle: TextStyle(color: Colors.black), // Texte en noir
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Bordure en noir
              ),
            ),
            style: const TextStyle(color: Colors.black), // Texte en noir
            onChanged: (value) {
              setState(() {
                quantity = int.tryParse(value) ?? 1;
                calculateTotal(ProduitInfos!, selectedProduct);
              });
            },
          ),
          const SizedBox(height: 16),
          // Warehouse Dropdown
          DropdownButtonFormField<String>(
            value: selectedWarehouse,
            decoration: const InputDecoration(
              labelText: 'Entrepôt',
              labelStyle: TextStyle(color: Colors.black), // Texte en noir
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Bordure en noir
              ),
            ),
            dropdownColor: Colors.white, // Fond du menu déroulant en blanc
            style: const TextStyle(
                color: Colors.black), // Texte du menu déroulant en noir
            items: const [
              DropdownMenuItem(
                  value: 'Keur Massar', child: Text('Keur Massar')),
              DropdownMenuItem(value: 'Yeumbeul', child: Text('Yeumbeul')),
              DropdownMenuItem(value: 'Pikine', child: Text('Pikine')),
            ],
            onChanged: (value) {
              setState(() {
                selectedWarehouse = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          // Stay Duration Input
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Séjour (jours)',
              labelStyle: TextStyle(color: Colors.black), // Texte en noir
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Bordure en noir
              ),
            ),
            style: const TextStyle(color: Colors.black), // Texte en noir
            onChanged: (value) {
              setState(() {
                stayDuration = int.tryParse(value) ?? 7;
                calculateTotal(ProduitInfos!, selectedProduct);
              });
            },
          ),
          const SizedBox(height: 16),
          // Delivery Switch
          SwitchListTile(
            title: const Text('Livraison',
                style: TextStyle(color: Colors.black)), // Texte en noir
            value: isDelivery,
            onChanged: (value) {
              setState(() {
                isDelivery = value;
                isDeliveryInt = isDelivery ? 1 : 0;
                calculateTotal(ProduitInfos!, selectedProduct);
              });
            },
            activeColor: Colors.red,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          // Total Amount Display
          Text(
            'Total: $totalAmount f',
            style: const TextStyle(
                color: Colors.black, fontSize: 18), // Texte en noir
          ),
          const SizedBox(height: 16),
          // Next Button
          ElevatedButton(
            onPressed: () {
              setState(() {
                currentStep = 2;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Bouton en orange
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bords arrondis
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Text('Suivant',
                  style: TextStyle(
                      color: Colors.white)), // Texte en blanc pour contraste
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentStep() {
    return Container(
      color: Colors.white, // Fond blanc
      padding: const EdgeInsets.all(16.0), // Ajout de padding pour l'espacement
      child: Column(
        children: [
          // Operator Dropdown
          DropdownButtonFormField<String>(
            value: selectedOperator,
            decoration: const InputDecoration(
              labelText: 'Opérateur',
              labelStyle: TextStyle(color: Colors.black), // Texte en noir
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Bordure en noir
              ),
            ),
            dropdownColor: Colors.white, // Fond du menu déroulant en blanc
            style: const TextStyle(
                color: Colors.black), // Texte du menu déroulant en noir
            items: const [
              DropdownMenuItem(
                value: 'Orange Money',
                child: Text('Orange Money'),
              ),
              DropdownMenuItem(
                value: 'Wave',
                child: Text('Wave'),
              ),
              DropdownMenuItem(
                value: 'Free Money',
                child: Text('Free Money'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedOperator = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          // Phone Number Input
          TextField(
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Numéro de téléphone',
              labelStyle: TextStyle(color: Colors.black), // Texte en noir
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Bordure en noir
              ),
            ),
            style: const TextStyle(color: Colors.black), // Texte en noir
            onChanged: (value) {
              setState(() {
                phoneNumber = value;
              });
            },
          ),
          const SizedBox(height: 16),
          // Total Amount Display
          Text(
            'Total: $totalAmount f',
            style: const TextStyle(
                color: Colors.black, fontSize: 18), // Texte en noir
          ),
          const SizedBox(height: 16),
          // Pay Button
          ElevatedButton(
            onPressed: () async {
              futureEntrepotId =
                  EntrepotRepository().getEntrepotIdByName(selectedWarehouse);
              entrepotID = await futureEntrepotId;
              RegisterReservation reservation = RegisterReservation(
                  resentrepot: entrepotID,
                  reservationduree: stayDuration,
                  resproducteur: producteur?.producterphone!.replaceAll(' ', ''),
                  resproduit: selectedProduct,
                  resquantite: quantity,
                  resdatetimevalidation: DateTime.now(),
                  livraison: isDeliveryInt,
                  estdeposer: 0,
                  encours: 1);
              await ReservationReposity().createReservation(reservation);
              print("Réservation créée avec succès");
              setState(() {
                currentStep = 3;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Bouton rouge
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bords arrondis
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Text(
                'Payer',
                style: TextStyle(
                    color: Colors.white), // Texte en blanc pour contraste
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSuccessMessageStep() {
    return Container(
      color: Colors.white, // Fond blanc
      padding: const EdgeInsets.all(16.0), // Ajout de padding pour l'espacement
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 100, color: teraOrange),
          const SizedBox(height: 16),
          const Text(
            'Opération réussie',
            style:
                TextStyle(fontSize: 24, color: Colors.black), // Texte en noir
          ),
          const SizedBox(height: 16),
          // Ok Button
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fermer l'overlay
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Bouton rouge
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bords arrondis
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Text(
                'Ok',
                style: TextStyle(
                    color: Colors.white), // Texte en blanc pour contraste
              ),
            ),
          ),
        ],
      ),
    );
  }
}
