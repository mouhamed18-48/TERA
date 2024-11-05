import 'dart:math';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../models/Produit.dart';
import '../models/QuantitiesByEntrepot.dart';

void changerPage(BuildContext context, Widget destination) {
  Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.fade,
      child: destination,
      duration: const Duration(milliseconds: 150),
    ),
  );
}

String getProductImage(String? type) {
  switch (type) {
    case 'carotte':
      return 'assets/images/les-carottes.png';
    case 'cacahuete':
      return 'assets/images/cacahuete.png';
    case 'patate':
      return 'assets/images/patate.png';
  // Ajoutez d'autres types ici
    default:
      return 'assets/images/default-image.png'; // Image par défaut
  }
}

double? getTarifParNom(List<Produit>? produitInfos, String? nom) {
  if (produitInfos == null || produitInfos.isEmpty) {
    return null; // La liste est vide ou nulle
  }

  for (Produit produit in produitInfos) {
    if (produit.produittype == nom) {
      return produit.produittarif; // Retourne le tarif si le nom correspond
    }
  }

  return null; // Aucun produit trouvé avec ce nom
}


double calculerTotalQuantite(List<QuantitiesByEntrepot>? quantitiesByEntrepotList) {
  if (quantitiesByEntrepotList == null || quantitiesByEntrepotList.isEmpty) {
    return 0.0; // Si la liste est nulle ou vide, retourner 0.0
  }

  return quantitiesByEntrepotList.fold(0.0, (sum, item) => sum + (item.totalquantite ?? 0.0));
}



