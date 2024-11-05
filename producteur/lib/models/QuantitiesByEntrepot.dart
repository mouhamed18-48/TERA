class QuantitiesByEntrepot{
  String? resentrepot;
  String? entrepotnom;
  double? totalquantite;
  String? total_quantite_7_jours;
  String? total_quantite_aujourd_hui;
  QuantitiesByEntrepot({
    this.resentrepot,
    this.entrepotnom,
    this.totalquantite,
    this.total_quantite_7_jours,
    this.total_quantite_aujourd_hui
  });

  QuantitiesByEntrepot.fromJson(Map<String, dynamic> json){
    resentrepot=json['res_entrepot'];
    entrepotnom=json['entrepot_nom'];
    totalquantite=json['total_quantite'] != null ? double.tryParse(json['total_quantite']) : null;
    total_quantite_7_jours=json['total_quantite_7_jours'];
    total_quantite_aujourd_hui=json['total_quantite_aujourd_hui'];
    ;
  }
}