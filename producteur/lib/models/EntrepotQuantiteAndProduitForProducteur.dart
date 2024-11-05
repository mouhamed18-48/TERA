class EntrepotQuantiteAndProduitForProducteur {
  String? entrepotname;
  double? quantite;
  String? produittype;
  int? temps_restant_jours;


  EntrepotQuantiteAndProduitForProducteur({
    this.entrepotname,
    this.quantite,
    this.produittype,
    this.temps_restant_jours
  });

  EntrepotQuantiteAndProduitForProducteur.fromJson(Map<String, dynamic> json){
    entrepotname=json['entrepot_name'];
    quantite=(json['quantite'] as num).toDouble();
    produittype=json['produit_type'];
    temps_restant_jours=json['temps_restant_jours'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['entrepot_name']=entrepotname;
    data['quantite']=quantite;
    data['produit_type']=produittype;
    data['temps_restant_jours']=temps_restant_jours;
    return data;
  }


}