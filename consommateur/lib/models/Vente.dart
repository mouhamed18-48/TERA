class Vente {
  String? venteProduit;
  int? venteQuantite;
  int? ventePrix;
  int? venteEncour;
  DateTime? venteDatetimeValidation;
  String? venteConsommateur;
  String? addresse;
  String? numero;

  Vente({
      this.venteProduit,
      this.venteQuantite,
      this.ventePrix,
      this.venteEncour,
      this.venteDatetimeValidation,
      this.venteConsommateur,
      this.addresse,
      this.numero
      });
  Vente.fromJson(Map<String, dynamic> json){
    venteProduit = json['vente_produit'];
    venteQuantite= json['vente_quantite'];
    ventePrix = json['vente_prix'];
    venteEncour = json['vente_encour'];
    venteDatetimeValidation = DateTime.parse(json['vente_datetime_validation']);
    venteConsommateur = json ['vente_consommateur'];
    addresse = json ['address'];
    numero = json['numero'];
  }
Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['venteProduit']=venteProduit;
    data['venteQuantite']=venteQuantite;
    data['ventePrix']=ventePrix;
    data['venteEncour']=venteEncour;
    data['venteDatetimeValidation']=venteDatetimeValidation?.toIso8601String();
    data['venteConsommateur']=venteConsommateur;
    data['addresse']=addresse;
    data['numero']=numero;
    return data;
}
}