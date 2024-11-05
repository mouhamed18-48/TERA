class Producteur{
  String? producterfirstname;
  String? productersecondname;
  String? producterphone;
  String? producterpassword;


  Producteur({
    this.producterfirstname,
    this.productersecondname,
    this.producterphone,
    this.producterpassword
  });

  Producteur.fromJson(Map<String , dynamic> json){
    producterfirstname=json['producter_firstname'];
    productersecondname=json['producter_secondname'];
    producterphone=json['producter_phone'];
    producterpassword=json['producter_password'];

  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['producter_firstname']=producterfirstname;
    data['producter_secondname']=productersecondname;
    data['producter_phone']=producterphone;
    data['producter_password']=producterpassword;

    return data;
  }

}