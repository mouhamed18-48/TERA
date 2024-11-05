class ProduitEntrepot {
  String? produit;
  String? totalquantite;


  ProduitEntrepot({
    this.produit,
    this.totalquantite
  });

  ProduitEntrepot.fromJson(Map<String, dynamic> json){
    produit=json['produit'];
    totalquantite=json['total_quantite'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['produit']=produit;
    data['total_quantite']=totalquantite;

    return data;
  }


}