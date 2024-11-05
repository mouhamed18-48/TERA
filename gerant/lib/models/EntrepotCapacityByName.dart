class Entrepotcapacitybyname{
  double? entrepotcapacitetotal;


  Entrepotcapacitybyname({
    this.entrepotcapacitetotal,
  });

  Entrepotcapacitybyname.fromJson(Map<String , dynamic> json){
    entrepotcapacitetotal=(json['entrepot_capacite_total'] as num).toDouble();

  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['gerant_entrepot_capacite_totalname']=entrepotcapacitetotal;

    return data;
  }

}