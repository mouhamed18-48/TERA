class reservationProd {
  String? producterfirstname;
  String? productersecondname;
  int? quantitereservation;
  String? resproduit;
  String? resid;
  String? resphone;
  int? temps_restant_jours;


  reservationProd({
    this.producterfirstname,
    this.productersecondname,
    this.quantitereservation,
    this.resproduit,
    this.resid,
    this.resphone,
    this.temps_restant_jours
  });

  reservationProd.fromJson(Map<String , dynamic> json){
    producterfirstname=json['producter_firstname'];
    productersecondname=json['producter_secondname'];
    quantitereservation=(json['quantite_reservation'] as num).toInt();
    resproduit=json['res_produit'];
    resphone=json['resphone'];
    resid=json['res_id'];
    temps_restant_jours=json['temps_restant_jours'];
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