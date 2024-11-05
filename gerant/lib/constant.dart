import "package:flutter/material.dart";

const Color teraOrange = Color.fromARGB(255, 247, 72, 29);
const Color teraDarkOrange = Color.fromARGB(255, 211, 61, 24);
const Color teraGrey = Color.fromARGB(255, 217, 217, 217);
const Color teraDark = Color.fromARGB(255, 54, 54, 54);
const Color teraYellow = Color.fromARGB(255, 228, 219, 140);
const Color teraDarkYellow = Color.fromARGB(255, 189, 183, 123);

class ImageProduct extends StatelessWidget {
  final String itemType;
  String path;
  double imageScale;
  ImageProduct({
    super.key,
    required this.itemType,
    this.path = "",
    this.imageScale = 1,
  });

  @override
  Widget build(BuildContext context) {
    if (itemType == "carotte") {
      path = "assets/les-carottes.png";
    }
    if (itemType == "patate") {
      path = "assets/patate.png";
    }
    if (itemType == "cacahuete") {
      path = "assets/cacahuete.png";
    }
    return itemType != "plus" ? Image.asset(
      path,
      scale: imageScale,
    ) : Icon(Icons.add, color: Colors.white, size: imageScale,);
  }
}

List<DropdownMenuEntry<String>> listeProduitDropdown = [
  DropdownMenuEntry(
      value: "carotte",
      label: "carotte",
      leadingIcon: ImageProduct(
        itemType: "carotte",
        imageScale: 15,
      )),
  DropdownMenuEntry(
      value: "patate",
      label: "patate",
      leadingIcon: ImageProduct(
        itemType: "patate",
        imageScale: 15,
      )),
  DropdownMenuEntry(
      value: "cacahuete",
      label: "cacahuete",
      leadingIcon: ImageProduct(
        itemType: "cacahuete",
        imageScale: 15,
      )),
];

List<DropdownMenuEntry<String>> listeProducteur = [
  const DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
  const DropdownMenuEntry(value: "Yacine Mbaye", label: "Yacine Mbaye"),
  const DropdownMenuEntry(
      value: "Papa Tahibou Tall", label: "Papa Tahibou Tall"),
  const DropdownMenuEntry(value: "Abdou Fatah", label: "Abdou Fatah"),
  const DropdownMenuEntry(value: "Modou Ndoye", label: "Modou Ndoye"),
  const DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
  const DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
  const DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
  const DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
  const DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
  const DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
];

List<DropdownMenuEntry<String>> listeRaison = [
  const DropdownMenuEntry(
      value: "Livraison complète", label: "Livraison complète"),
  const DropdownMenuEntry(value: "Vente", label: "Vente"),
  const DropdownMenuEntry(value: "Produit abîmé", label: "Produit abîmé"),
  const DropdownMenuEntry(value: "Remboursement", label: "Remboursement"),
  const DropdownMenuEntry(value: "Annulation vente", label: "Annulation vente"),
  const DropdownMenuEntry(value: "Autres", label: "Autres"),
];
