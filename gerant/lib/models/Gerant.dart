class Gerant{
  String? gerantname;
  String? gerantid;
  String? gerantentrepot;
  String? gerantpassword;


  Gerant({
    this.gerantname,
    this.gerantid,
    this.gerantentrepot,
    this.gerantpassword
  });

  Gerant.fromJson(Map<String , dynamic> json){
    gerantname=json['gerant_name'];
    gerantid=json['gerant_id'];
    gerantentrepot=json['gerant_entrepot'];
    gerantpassword=json['gerant_password'];

  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['gerant_name']=gerantname;
    data['gerant_id']=gerantid;
    data['gerant_entrepot']=gerantentrepot;
    data['gerant_password']=gerantpassword;

    return data;
  }

}