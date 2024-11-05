class Reservedproductsentrepot {
  String? produittype;
  String? totalquantite;
  String? total_quantite_7_jours;
  String? total_quantite_aujourd_hui;


  Reservedproductsentrepot({
    this.produittype,
    this.totalquantite,
    this.total_quantite_7_jours,
    this.total_quantite_aujourd_hui
  });

  Reservedproductsentrepot.fromJson(Map<String , dynamic> json){
    produittype=json['produit_type'];
    totalquantite=json['total_quantite'];
    total_quantite_7_jours=json['total_quantite_7_jours'];
    total_quantite_aujourd_hui=json['total_quantite_aujourd_hui'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['produit_type']=produittype;
    data['total_quantite']=totalquantite;
    data['total_quantite_7_jours']=total_quantite_7_jours;
    data['total_quantite_aujourd_hui']=total_quantite_aujourd_hui;
    return data;
  }
}