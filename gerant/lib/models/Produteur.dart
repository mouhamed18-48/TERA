class Producteur{
  String? producterfirstname;
  String? productersecondname;
  String? producterphone;


  Producteur({
    this.producterfirstname,
    this.productersecondname,
    this.producterphone
  });

  Producteur.fromJson(Map<String , dynamic> json){
    producterfirstname=json['producter_firstname'];
    productersecondname=json['producter_secondname'];
    producterphone=json['producter_phone'];

  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['producter_firstname']=producterfirstname;
    data['producter_secondname']=productersecondname;
    data['producter_phone']=producterphone;

    return data;
  }

}