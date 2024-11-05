class Ventes {
  String? venteId;
  String? venteProduit;
  String? venteQuantite;
  int? ventePrix;
  int? tempsLivraison;

  Ventes({
    this.venteProduit,
    this.venteQuantite,
    this.ventePrix,
    this.venteId,
    this.tempsLivraison
  });
  Ventes.fromJson(Map<String, dynamic> json){
    venteId = json['vente_id'];
    venteProduit= json['vente_produit'];
    venteQuantite = json['vente_quantite'];
    ventePrix = json['vente_prix'];
    tempsLivraison = json['temps_livraison'];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['vente_id']=venteId;
    data['vente_produit']=venteProduit;
    data['vente_quantite']=venteQuantite;
    data['vente_prix']=ventePrix;
    data['temps_livraison']=tempsLivraison;
    return data;
  }
}