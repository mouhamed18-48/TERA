class Entrepotlivraison{
  String? producterfirstname;
  String? productersecondname;
  double? quantitereservation;
  String? resproduit;
  String? resid;
  String? resphone;


  Entrepotlivraison({
    this.producterfirstname,
    this.productersecondname,
    this.quantitereservation,
    this.resproduit,
    this.resid,
    this.resphone
  });

  Entrepotlivraison.fromJson(Map<String , dynamic> json){
    producterfirstname=json['producter_firstname'];
    productersecondname=json['producter_secondname'];
    quantitereservation=(json['quantite_reservation'] as num).toDouble();
    resproduit=json['res_produit'];
    resphone=json['resphone'];
    resid=json['res_id'];
  }



  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['producter_firstname']=producterfirstname;
    data['producter_secondname']=productersecondname;
    data['entrepot_adresse']=quantitereservation;
    data['res_produit']=resproduit;
    data['res_id']=resid;
    return data;
  }
}