class ProduitName {
  String? produittype;


  ProduitName({
    this.produittype,
  });

  ProduitName.fromJson(Map<String, dynamic> json){
    produittype=json['produit_type'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['produit_type']=produittype;

    return data;
  }


}