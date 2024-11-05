class EntrepotClass{
  String? entrepotid;
  String? entrepotnom;


  EntrepotClass({
    this.entrepotid,
    this.entrepotnom
  });

  EntrepotClass.fromJson(Map<String , dynamic> json){
    entrepotid=json['entrepot_id'];
    entrepotnom=json['entrepot_nom'];
  }



  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['entrepot_id']=entrepotid;
    data['entrepot_nom']=entrepotnom;

    return data;
  }

}