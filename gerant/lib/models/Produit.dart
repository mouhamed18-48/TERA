class Produit {
  String? produittype;
  double? produitprix;


  Produit({
    this.produittype,
    this.produitprix
  });

  Produit.fromJson(Map<String, dynamic> json){
    produittype=json['produit_type'];
    produitprix=(json['produit_prix'] as num).toDouble();
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['produit_type']=produittype;
    data['produit_prix']=produitprix;

    return data;
  }


}