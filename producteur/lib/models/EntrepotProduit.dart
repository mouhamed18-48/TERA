class EntrepotProduit{
  String? entrepotid;
  String? produittype;
  double? capacite;

  EntrepotProduit({
    this.entrepotid,
    this.produittype,
    this.capacite
  });

  EntrepotProduit.fromJson(Map<String, dynamic> json){
    entrepotid=json['entrepot_id'];
    produittype=json['produit_type'];
    capacite=(json['capacite'] as num).toDouble();
  }
}