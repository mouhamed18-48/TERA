class Entrepot{
  String? entrepotid;
  String? entrepotnom;
  String? entrepotadresse;
  double? entrepotlatitude;
  double? entrepotlongitude;
  double? entrepotcapacite;
  String? contact;


  Entrepot({
    this.entrepotid,
    this.entrepotnom,
    this.entrepotadresse,
    this.entrepotlatitude,
    this.entrepotlongitude,
    this.entrepotcapacite,
    this.contact
  });

  Entrepot.fromJson(Map<String , dynamic> json){
    entrepotid=json['entrepot_id'];
    entrepotnom=json['entrepot_nom'];
    entrepotadresse=json['entrepot_adresse'];
    entrepotlatitude=(json['entrepot_latitude'] as num).toDouble();
    entrepotlongitude=(json['entrepot_longitude'] as num).toDouble();
    entrepotcapacite=(json['entrepot_capacite_total'] as num).toDouble();
    contact=json['contact'];
  }



  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['entrepot_id']=entrepotid;
    data['entrepot_nom']=entrepotnom;
    data['entrepot_adresse']=entrepotadresse;
    data['entrepot_latitude']=entrepotlatitude;
    data['entrepot_longitude']=entrepotlongitude;
    data['entrepot_capacite_total']=entrepotcapacite;
    data['contact']=contact;

    return data;
  }

}