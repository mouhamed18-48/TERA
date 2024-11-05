class Update {
  String? resproducteur;
  String? resentrepot;
  String? resproduit;
  int? resquantite;

  Update({
    this.resproducteur,
    this.resentrepot,
    this.resproduit,
    this.resquantite,
  });

  Update.fromJson(Map<String, dynamic> json) {
    resproducteur = json['res_producteur'];
    resentrepot = json['res_entrepot'];
    resproduit = json['res_produit'];
    resquantite = json['res_quantite'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['resProducteur'] = resproducteur;
    data['resEntrepot'] = resentrepot;
    data['resProduit'] = resproduit;
    data['Quantite'] = resquantite;

    return data;
  }
}