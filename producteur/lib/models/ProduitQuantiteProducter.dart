class ProduitQuantiteProducteur {
  String? produittype;
  String? totalquantite;
  String? total_quantite_aujourd_hui;
  String? total_quantite_7_jours;


  ProduitQuantiteProducteur({
    this.produittype,
    this.totalquantite,
    this.total_quantite_7_jours,
    this.total_quantite_aujourd_hui
  });

  ProduitQuantiteProducteur.fromJson(Map<String, dynamic> json){
    produittype=json['produit_type'];
    totalquantite=json['total_quantite'].toString();
    total_quantite_aujourd_hui=json['total_quantite_aujourd_hui'].toString();
    total_quantite_7_jours=json['total_quantite_7_jours'].toString();
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['produit_type']=produittype;
    data['total_quantite']=totalquantite;
    data['total_quantite_aujourd_hui']=total_quantite_aujourd_hui;
    data['total_quantite_7_jours']=total_quantite_7_jours;
    return data;
  }


}