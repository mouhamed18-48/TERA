class Produit {
  String? produittype;
  double? produittarif;
  double? produitprix;


  Produit({
    this.produittype,
    this.produittarif,
    this.produitprix
  });

  Produit.fromJson(Map<String, dynamic> json){
    produittype=json['produit_type'];
    produittarif=(json['produit_tarif'] as num).toDouble();
    produitprix=(json['produit_prix'] as num).toDouble();
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['produit_type']=produittype;
    data['produit_tarif']=produittarif;
    data['produit_prix']=produitprix;

    return data;
  }


}