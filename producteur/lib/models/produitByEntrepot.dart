class produitByEntrepot {
  String? entrepotid;
  String? entrepotname;
  int? distinctProductCount;
  String? totalquantity;


  produitByEntrepot({
    this.entrepotid,
    this.entrepotname,
    this.distinctProductCount,
    this.totalquantity
  });

  produitByEntrepot.fromJson(Map<String, dynamic> json){
    entrepotid=json['entrepot_id'];
    entrepotname=json['entrepot_name'];
    distinctProductCount=(json['distinct_product_count'] as num).toInt();
    totalquantity=json['total_quantity'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['entrepot_id']=entrepotid;
    data['entrepot_name']=entrepotname;
    data['distinct_product_count']=distinctProductCount;
    data['total_quantity']=totalquantity;
    return data;
  }


}