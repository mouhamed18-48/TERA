class ProduitProducer {
  String? resproduit;
  String? totalquantite;


  ProduitProducer({
    this.resproduit,
    this.totalquantite
  });

  ProduitProducer.fromJson(Map<String, dynamic> json){
    resproduit=json['res_produit'];
    totalquantite=json['total_quantite'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['res_produit']=resproduit;
    data['total_quantite']=totalquantite;

    return data;
  }


}