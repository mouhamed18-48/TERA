import "package:flutter/material.dart";
import "package:page_transition/page_transition.dart";

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
    if(itemType == "carotte"){
      path = "assets/les-carottes.png";
    }
    if(itemType == "patate"){
      path = "assets/patate.png";
    }
    if(itemType == "cacahuete"){
      path = "assets/cacahuete.png";
    }
    return Image.asset(path, scale: imageScale,);
  }
}

// List <DropdownMenuEntry<String>> listeProduitDropdown = [
//   DropdownMenuEntry(value: "carotte", label: "carotte", leadingIcon: ImageProduct(itemType: "carotte", imageScale: 15,)),
//   DropdownMenuEntry(value: "pomme de terre", label: "pomme de terre", leadingIcon: ImageProduct(itemType: "pomme de terre", imageScale: 15,)),
//   DropdownMenuEntry(value: "arachide", label: "arachide", leadingIcon: ImageProduct(itemType: "arachide", imageScale: 15,)),
//   DropdownMenuEntry(value: "carotte", label: "carotte", leadingIcon: ImageProduct(itemType: "carotte", imageScale: 15,)),
//   DropdownMenuEntry(value: "carotte", label: "carotte", leadingIcon: ImageProduct(itemType: "carotte", imageScale: 15,)),
//   DropdownMenuEntry(value: "carotte", label: "carotte", leadingIcon: ImageProduct(itemType: "carotte", imageScale: 15,)),
//   DropdownMenuEntry(value: "carotte", label: "carotte", leadingIcon: ImageProduct(itemType: "carotte", imageScale: 15,)),
//   DropdownMenuEntry(value: "carotte", label: "carotte", leadingIcon: ImageProduct(itemType: "carotte", imageScale: 15,)),
// ];

// List <DropdownMenuEntry<String>> listeProducteur = [
//   DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
//   DropdownMenuEntry(value: "Yacine Mbaye", label: "Yacine Mbaye"),
//   DropdownMenuEntry(value: "Papa Tahibou Tall", label: "Papa Tahibou Tall"),
//   DropdownMenuEntry(value: "Abdou Fatah", label: "Abdou Fatah"),
//   DropdownMenuEntry(value: "Modou Ndoye", label: "Modou Ndoye"),
//   DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
//   DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
//   DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
//   DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
//   DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
//   DropdownMenuEntry(value: "Ibrahima Dia", label: "Ibrahima Dia"),
// ];

List <DropdownMenuEntry<String>> listeRaison = [
  DropdownMenuEntry(value: "Livraison complète", label: "Livraison complète"),
  DropdownMenuEntry(value: "Vente", label: "Vente"),
  DropdownMenuEntry(value: "Produit abîmé", label: "Produit abîmé"),
  DropdownMenuEntry(value: "Remboursement", label: "Remboursement"),
  DropdownMenuEntry(value: "Annulation vente", label: "Annulation vente"),
  DropdownMenuEntry(value: "Autres", label: "Autres"),
];

class Responsive{
  double width(context, double scale){
    double responsiveWidth = MediaQuery.of(context).size.width;
    return responsiveWidth/scale;
  }
  double height(context, double scale){
    double responsiveHeight = MediaQuery.of(context).size.height;
    return responsiveHeight/scale;
  }
}

List <DropdownMenuEntry<String>> listePaiement = [
  DropdownMenuEntry(value: "Orange Money", label: "Orange Money"),
  DropdownMenuEntry(value: "Wave", label: "Wave"),
  DropdownMenuEntry(value: "Free Money", label: "Free Money"),
  DropdownMenuEntry(value: "Cash", label: "Cash"),
];


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