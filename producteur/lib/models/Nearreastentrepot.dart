class Nearreastentrepot{
  String? entrepotNom;
  double? entrepotCapaciteTotal;
  double? distanceKm;
  int? nombre_produits;


  Nearreastentrepot({
    this.entrepotNom,
    this.entrepotCapaciteTotal,
    this.distanceKm,
    this.nombre_produits
  });

  Nearreastentrepot.fromJson(Map<String , dynamic> json){
    entrepotNom=json['entrepot_nom'];
    entrepotCapaciteTotal=(json['entrepot_capacite_total'] as num).toDouble();
    distanceKm=(json['distance_km'] as num).toDouble();
    nombre_produits=(json['nombre_produits'] as num).toInt();

  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['entrepot_nom']=entrepotNom;
    data['entrepot_capacite_total']=entrepotCapaciteTotal;
    data['distance_km']=distanceKm;

    return data;
  }

}