class Reservation {
  String? resid;
  String? resproducteur;
  String? resentrepot;
  String? resproduit;
  DateTime? resdatetimevalidation;
  int? estdeposer=0;
  int? resquantite;
  int? encours = 1;
  int? reservationduree;
  int? livraison;

  Reservation({
    this.resid,
    this.resproducteur,
    this.resentrepot,
    this.resproduit,
    this.resdatetimevalidation,
    this.estdeposer,
    this.resquantite,
    this.encours,
    this.reservationduree,
    this.livraison,
  });

  Reservation.fromJson(Map<String, dynamic> json) {
    resid = json['res_id'];
    resproducteur = json['res_producteur'];
    resentrepot = json['res_entrepot'];
    resproduit = json['res_produit'];
    resdatetimevalidation = DateTime.parse(json['res_datetime_validation']);
    estdeposer = json['estdeposer'];
    resquantite = json['res_quantite'].toDouble();
    encours = json['encours'];
    reservationduree = json['reservation_duree'];
    livraison = json['livraison'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['resId'] = resid;
    data['resProducteur'] = resproducteur;
    data['resEntrepot'] = resentrepot;
    data['resProduit'] = resproduit;
    data['resDatetimeValidation'] = resdatetimevalidation?.toIso8601String();
    data['estDeposer'] = estdeposer;
    data['resQuantite'] = resquantite;
    data['encours'] = encours;
    data['reservationDuree'] = reservationduree;
    data['livraison'] = livraison;

    return data;
  }
}
