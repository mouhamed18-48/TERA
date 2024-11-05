class Producerreservation{
  String? firstname;
  String? secondname;
  int? reservationsencours;
  String? phone;


  Producerreservation({
    this.firstname,
    this.secondname,
    this.reservationsencours,
    this.phone
  });

  Producerreservation.fromJson(Map<String , dynamic> json){
    firstname=json['firstname'];
    secondname=json['secondname'];
    reservationsencours=json['reservations_en_cours'];
    phone=json['phone'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstname']=firstname;
    data['secondname']=secondname;
    data['reservations_en_cours']=reservationsencours;
    return data;
  }

}