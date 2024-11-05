class Consommateur{
  String? consommateurfirstname;
  String? consommateursecondname;
  String? consommateurphone;
  String? consommateurpassword;


  Consommateur({
    this.consommateurfirstname,
    this.consommateursecondname,
    this.consommateurphone,
    this.consommateurpassword
  });

  Consommateur.fromJson(Map<String , dynamic> json){
    consommateurfirstname=json['consommateur_firstname'];
    consommateursecondname=json['consommateur_secondname'];
    consommateurphone=json['consommateur_phone'];
    consommateurpassword=json['consommateur_password'];

  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['consommateur_firstname']=consommateurfirstname;
    data['consommateur_secondname']=consommateursecondname;
    data['consommateur_phone']=consommateurphone;
    data['consommateur_password']=consommateurpassword;

    return data;
  }

}