class ProduitDispo {
  String? produitType;
  int? produitPrix;
  int? quantite;


  ProduitDispo({
    this.produitType,
    this.produitPrix,
    this.quantite
  });

  ProduitDispo.fromJson(Map<String , dynamic> json){
    produitType =json['produit_type'];
    quantite=json['quantite'];
    produitPrix=json['produit_prix'];
  }



  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['produit_type']=produitType;
    data['quantite']=produitPrix as num;
    data['produit_prix']=quantite;
    return data;
  }

}