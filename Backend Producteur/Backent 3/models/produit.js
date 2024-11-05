const db=require('../configuration/database');



//récupérer les types de produits distincts pour un producteur donné.
 class   Produit  {



    static createReservation(reservationData, callback) {
        const {
            resId,
            resProducteur,
            resEntrepot,
            resProduit,
            resDatetimeValidation,
            estDeposer,
            resQuantite,
            encours,
            reservationDuree,
            livraison,
        } = reservationData;
    
        const insertReservationQuery = `
            INSERT INTO reservation (
                res_id,
                res_producteur,
                res_entrepot,
                res_produit,
                res_datetime_validation,
                estDeposer,
                res_quantite,
                encours,
                reservation_duree,
                livraison
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `;

        const insertReservationQuery_2 = `
            INSERT INTO reservation_update (
                res_id,
                res_producteur,
                res_entrepot,
                res_produit,
                res_datetime_validation,
                estDeposer,
                res_quantite,
                encours,
                reservation_duree,
                livraison
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `;

        
    
        // Exécution de l'insertion
        db.query(
            insertReservationQuery,
            [
                resId,
                resProducteur,
                resEntrepot,
                resProduit,
                resDatetimeValidation,
                estDeposer,
                resQuantite,
                encours,
                reservationDuree,
                livraison,
            ],
            (err, result) => {
                if (err) {
                    callback(err, null);
                } else {
                    db.query(
                        insertReservationQuery_2,
                        [
                            resId,
                            resProducteur,
                            resEntrepot,
                            resProduit,
                            resDatetimeValidation,
                            estDeposer,
                            resQuantite,
                            encours,
                            reservationDuree,
                            livraison,
                        ],
                        (err, result) => {
                            if (err) {
                                callback(err, null);
                            } else {
                                
                                const updateEntrepotProduitQuantite = `
                                    UPDATE entrepotproduit
                                    SET capacite = capacite + ?
                                    WHERE entrepot_id = ? AND produit_type = ?
                                `;
                
                                db.query(
                                    updateEntrepotProduitQuantite,
                                    [resQuantite, resEntrepot, resProduit],
                                    (err, result) => {
                                        if (err) {
                                            console.error('Erreur lors de la mise à jour des quantités du produit :', err);
                                            callback(err, null);
                                        } else {
                                            // Mise à jour de la capacité totale de l'entrepôt
                                            const updateEntrepotCapacite = `
                                                UPDATE entrepot
                                                SET entrepot_capacite_total = entrepot_capacite_total - ?
                                                WHERE entrepot_id = ?
                                            `;
                                            db.query(
                                                updateEntrepotCapacite,
                                                [resQuantite, resEntrepot],  // Correction ici, on soustrait la quantité et on passe l'ID de l'entrepôt
                                                (err, result) => {
                                                    if (err) {
                                                        console.error('Erreur lors de la mise à jour de la capacité de l\'entrepôt :', err);
                                                        callback(err, null);
                                                    } else {
                                                        // Retourne le résultat final après la mise à jour
                                                        callback(null, result);
                                                    }
                                                }
                                            );
                                        }
                                    }
                                );
                            }
                        }
                    );
                }
            }
        );
    }
    

static getDistinctProductTypes(resProducterData, callback) {

    const { resProducter } = resProducterData;
    const query = `
        SELECT DISTINCT p.produit_type
        FROM reservation_update r
        JOIN produit p ON r.res_produit = p.produit_type
        WHERE r.res_producteur = ? AND r.encours = 1 AND r.res_quantite>0
    `;
    db.query(query, [resProducter], (err, results) => {
        if (err) {
            return callback(err);
        } else if (results.length > 0) {
            return callback(null, results);
        } else {
            return callback(null, []);
        }
    });
}




// Pour récupérer l'ensemble des produits en réservation pour un producteur et sommer les quantités pour chaque produit
static getProductsWithQuantities(producterPhone, callback) {
    const getProductsWithQuantitiesQuery = `
      SELECT p.produit_type, 
      SUM(r.res_quantite) AS total_quantite ,
      SUM(CASE 
        WHEN DATE(r.res_datetime_validation) = CURDATE() THEN r.res_quantite 
        ELSE 0 
    END) AS total_quantite_aujourd_hui,
    SUM(CASE 
        WHEN DATE_ADD(r.res_datetime_validation, INTERVAL r.reservation_duree DAY) BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY) 
        THEN r.res_quantite 
        ELSE 0 
    END) AS total_quantite_7_jours
      FROM reservation_update r
      JOIN produit p ON r.res_produit = p.produit_type 
      WHERE r.res_producteur = ? AND r.encours = 1 AND r.res_quantite>0 GROUP BY  p.produit_type;
    `;
    db.query(getProductsWithQuantitiesQuery, [producterPhone], (err, result) => {
      if (err) {
        return callback(err);
      } else if (result.length > 0) {
        return callback(null, result);
      } else {
        return callback(null, []);
      }
    });
  }

  static getNumberProduiNearestEntrepot(userEntrepotData, callback) {
    const { producterPhone, entrepotName } = userEntrepotData;
    const query = `
        
SELECT COUNT(DISTINCT res_produit) AS n_produit FROM reservation_update WHERE res_producteur =? AND encours=1 AND res_quantitte>0 AND res_entrepot = (SELECT entrepot_id FROM entrepot WHERE entrepot_nom = ?);

`;

    db.query(query, [ producterPhone, entrepotName], (err, result) => {
        if (err) {
            return callback(err, null);
        } else {
            return callback(null, result);
        }
    });
}

static getProduits(callback) {
    const query = `
        SELECT produit_type, produit_tarif, produit_prix 
        FROM produit
    `;
    db.query(query, (err, result) => {
        if (err) {
            return callback(err, null);
        } else {
            return callback(null, result);
        }
    });
}



// Les productions

static createProduction(productionData, callback) {
    const { nombreChamps, adresse, producteurPhone } = productionData;

    const query = `
        INSERT INTO production (nombre_produit, adresse, producteur_phone)
        VALUES (?, ?, ?);
    `;

    db.query(query, [nombreChamps, adresse, producteurPhone], (err, result) => {
        if (err) {
            callback(err, null);
        } else {
            callback(null, result);
        }
    });
}

// Nouvelle méthode pour vérifier si une ligne existe
static checkProductionExists(producteurPhone, callback) {
    const query = `SELECT * FROM production WHERE producteur_phone = ?`;
    db.query(query, [producteurPhone], (err, result) => {
        if (err) {
            callback(err, null);
        } else {
            callback(null, result.length > 0); // retourne true si une ligne existe
        }
    });
}

static createProduitProducteur(produitproducteurData, callback){
    const { producterPhone, produits } = produitproducteurData;
    // Prépare les valeurs pour l'insertion
const values = produits.map(produit => [producterPhone, produit]);


    const query = `
    INSERT INTO produitProducteur (producter_phone, produit_type)
    VALUES ?
`;

db.query(query, [values], (err, result) => {
    if(err){
        callback(err, null);
    }else{
        callback(null, result);
    }
});

}

// Pour récupérer la quantité de produit réservée dans chaque entrepôt pour un producteur donné et un produit spécifique,

static getQuantitiesByEntrepot(reservationData, callback) {

    const { producterPhone, produitType } = reservationData;
    const getQuantitiesByEntrepotQuery = `
      SELECT
          r.res_entrepot,
          e.entrepot_nom,
          SUM(r.res_quantite) AS total_quantite,
          SUM(CASE 
        WHEN DATE(r.res_datetime_validation) = CURDATE() THEN r.res_quantite 
        ELSE 0 
    END) AS total_quantite_aujourd_hui,
    SUM(CASE 
        WHEN DATE_ADD(r.res_datetime_validation, INTERVAL r.reservation_duree DAY) BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY) 
        THEN r.res_quantite 
        ELSE 0 
    END) AS total_quantite_7_jours
      FROM
          reservation_update r
      JOIN
          entrepot e ON r.res_entrepot = e.entrepot_id
      WHERE
          r.res_producteur = ? AND r.res_produit = ? AND r.encours = 1 AND r.res_quantite>0
      GROUP BY
          r.res_entrepot, e.entrepot_nom;
    `;
    db.query(getQuantitiesByEntrepotQuery, [producterPhone, produitType], (err, result) => {
      if (err) {
        return callback(err);
      } else if (result.length > 0) {
        return callback(null, result);
      } else {
        return callback(null, []);
      }
    });
  }

  static getProduitEntrepot(entrepotData, callback) {
    const { entrepotId} = entrepotData;
    const getProduitEntrepotQuery = 'SELECT `produit_type` FROM `entrepotproduit` WHERE `entrepot_id` = ?'; 
    db.query(getProduitEntrepotQuery, [entrepotId], (err, produits) => {
        if (err) {
            return callback(err);
        } 
        else if (produits.length > 0) {
            return callback(null, produits);
        } else {
            return callback(null, null);
        }
    });
}

static getNombreProduitsReserve({ producterPhone, entrepotName }, callback) {
    const query = `
      SELECT COUNT(*) AS nombre_produits
      FROM reservation_update r
      JOIN producter p ON r.res_producteur = p.producter_phone
      JOIN entrepot e ON r.res_entrepot = e.entrepot_id
      WHERE p.producter_phone = ? AND e.entrepot_nom = ? AND r.encours=1 AND r.res_quantite>0;
    `;
    db.query(query, [producterPhone, entrepotName], (err, results) => {
      if (err) {
        callback(err, null);
      } else {
        callback(null, results[0].nombre_produits);
      }
    });
  }



 }




module.exports = Produit;