class Numberreservationexpiredin7day{
  String? nreservationsexpiring_today;


  Numberreservationexpiredin7day({
    this.nreservationsexpiring_today,
  });

  Numberreservationexpiredin7day.fromJson(Map<String , dynamic> json){
    nreservationsexpiring_today=json['nreservationsexpiring_today'];

  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['n_reservations_expiring_in_5_days']=nreservationsexpiring_today;

    return data;
  }

}