class NombreProduit {
  int? nproduit;


  NombreProduit({
    this.nproduit,
  });

  NombreProduit.fromJson(Map<String , dynamic> json){
    nproduit=json['n_produit'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['n_produit']=nproduit;
    return data;
  }
}