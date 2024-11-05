import 'package:flutter/material.dart';
import 'package:producteur/constant.dart';
import 'package:producteur/screens/stock.dart';
import 'package:producteur/screens/teraTextfield.dart';

import '../models/Producteur.dart';
import '../repositories/production_repository.dart';
import '../repositories/produit_producteur_repository.dart';
import '../shared_preferences/producteur_data_manager.dart';

class ProductionInfos extends StatefulWidget {
  const ProductionInfos({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<ProductionInfos> {
  final TextEditingController _nombreChampsController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _newProductController = TextEditingController();
  final ProductionRepository productionRepository = ProductionRepository();
  final ProduitProductionRepository produitProductionRepository =
      ProduitProductionRepository();
  Producteur? producteur;
  Future<Producteur?>? futureProducter;
  List<String> selectedProducts = [];
  List<String> availableProducts = ['Maïs', 'Blé', 'Riz', 'Soja', 'Tomate'];
  final List<String> worldAddresses = [
    "Kaolack",
    "Thies",
    "Tambacounda",
    "Diourbel"
  ];
  List<String> filteredAddresses = []; // Liste filtrée pour suggestions

  @override
  void initState() {
    super.initState();
    futureProducter = ProducteurDataManager.loadStoreData();
    _initClass();
  }

  Future<void> _initClass() async {
    producteur = await futureProducter;
    setState(() {}); // Rebuild after loading data
  }

  void addProduct(String product) {
    setState(() {
      selectedProducts.add(product);
      availableProducts.remove(product);
    });
  }

  void removeProduct(String product) {
    setState(() {
      selectedProducts.remove(product);
      availableProducts.add(product);
    });
  }

  void _filterAddresses(String input) {
    setState(() {
      filteredAddresses = worldAddresses
          .where(
              (address) => address.toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Entrez les informations",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Relatives à votre production",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Nombre de champs
                  const Text(
                    "Combien de champs possédez vous?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TeraTextField(
                    controller: _nombreChampsController,
                    inputType: TextInputType.number,
                    name: "",
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Renseignez les addresses de vos champs",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Adresse des champs avec suggestions
                  TeraTextField(
                    controller: _adresseController,
                    inputType: TextInputType.text,
                    name: "",
                    onChanged: _filterAddresses,
                  ),
                  const SizedBox(height: 20.0),

                  // Affichage des suggestions filtrées
                  if (filteredAddresses.isNotEmpty)
                    SingleChildScrollView(
                      child: Container(
                        color: const Color(0xFFD9D9D9),
                        height: 100,
                        child: ListView.builder(
                          itemCount: filteredAddresses.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(filteredAddresses[index]),
                              onTap: () {
                                _adresseController.text =
                                    filteredAddresses[index];
                                setState(() {
                                  filteredAddresses =
                                      []; // Cache les suggestions après la sélection
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  const SizedBox(height: 20.0),

                  // Liste des produits disponibles
                  const Text(
                    'Choisir des produits',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: availableProducts.map((product) {
                      return GestureDetector(
                        onTap: () => addProduct(product),
                        child: Chip(
                          label: Text(product),
                          backgroundColor: const Color(0xFFD9D9D9),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),

                  // Produits sélectionnés
                  const Text(
                    'Produits sélectionnés',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: selectedProducts.map((product) {
                      return GestureDetector(
                        onTap: () => removeProduct(product),
                        child: Chip(
                          label: Text(
                            product,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: const Color(0xFFF7481D),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () => removeProduct(product),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),

                  // Bouton Confirmer
                  Center(
                    child: InkWell(
                      onTap: () {
                        // Appel aux méthodes pour enregistrer les données
                        registerProduction(producteur?.producterphone);
                        registerProducts(producteur?.producterphone);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AjoutStock(),
                          ),
                        );
                      },
                      child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                              color: teraOrange,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                            child: Text('Confirmer',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void registerProduction(String? phone) {
    // Appeler la méthode de ProductionRepository pour enregistrer la production
    productionRepository
        .registerProduction(
      int.parse(_nombreChampsController.text),
      _adresseController.text,
      phone, // Exemple de numéro de téléphone du producteur
    )
        .then((_) {
      // Afficher un message de succès ou gérer les erreurs
    });
  }

  void registerProducts(String? phone) {
    // Ajouter les nouveaux produits à la liste sélectionnée
    if (_newProductController.text.isNotEmpty) {
      selectedProducts.add(_newProductController.text);
    }

    // Appeler la méthode de ProduitRepository pour enregistrer les produits
    produitProductionRepository
        .registerProducts(
      phone, // Exemple de numéro de téléphone du producteur
      selectedProducts,
    )
        .then((success) {
      if (success) {
        // Afficher un message de succès ou gérer les erreurs
      }
    });
  }
}
