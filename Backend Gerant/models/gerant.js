const db = require('../configuration/database');
const bcrypt = require('bcrypt');

class Gerant {


    static createGerant(gerantData, callback) {
        const { gerantName, gerantEntrepot, gerantId, gerantPassword } = gerantData;
        
        // Hacher le mot de passe avant de le sauvegarder dans la base de données
        bcrypt.hash(gerantPassword, 10, (err, hashedPassword) => {
            if (err) return callback(err);

            const query = `
                INSERT INTO gerant (gerant_id, gerant_name, gerant_entrepot, gerant_password)
                VALUES (?, ?, ?, ?)
            `;
            db.query(query, [gerantId, gerantName, gerantEntrepot, hashedPassword], (err, result) => {
                if (err) return callback(err);
                callback(null, result);
            });
        });
    }
    

    static findById(gerantData, callback) {

        const { gerantId ,gerantPassword} = gerantData;

        console.log(gerantId, gerantPassword)
        const query = `SELECT * FROM gerant WHERE gerant_id = ?`;
        db.query(query, [gerantId], (err, results) => {
            if(err){
                callback(err);
            }else if(results.length>0){
                const gerant = results[0];
                bcrypt.compare(gerantPassword, gerant.gerant_password, (err, result)=>{

                    if(result){
                        callback(null, gerant);
                    }else{
                        callback(null, null);
                    }
                });
            }else{
                callback(null, null);
            }
        })
    }

    static getEntrepotCapacityByName(entrepotName, callback) {
        const getEntrepotCapacityByNameQuery = 'SELECT `entrepot_capacite_total` FROM `entrepot` WHERE `entrepot_nom` = ?';
        db.query(getEntrepotCapacityByNameQuery, [entrepotName], (err, results) => {
            if (err) {
                return callback(err);
            } else if (results.length > 0) {
                return callback(null, results);
            } else {
                return callback(null, null);
            }
        });
    }

    static getNumberReservationExpiredIn7Day(entrepotName, callback) {
        const getNumberReservationExpiredIn5DayQuery = `
          SELECT
            SUM(CASE 
                WHEN DATE(DATE_ADD(r.res_datetime_validation, INTERVAL r.reservation_duree DAY)) = CURDATE()
                THEN 1 
                ELSE 0 
            END) AS nreservationsexpiring_today
          FROM reservation_update r 
          JOIN entrepot e ON r.res_entrepot = e.entrepot_id
          WHERE e.entrepot_nom = ? AND r.encours=1;
        `;
      
        db.query(getNumberReservationExpiredIn5DayQuery, [entrepotName], (err, result) => {
          if (err) {
            console.log('Erreur:', err);
            return callback(err);
          } else if (result.length > 0) {
            return callback(null, result);
          } else {
            return callback(null, []);
          }
        });
      }

      static getDistinctProductTypes(entrepotNameData, callback) {

        const { entrepotName } = entrepotNameData;
    
        const query = `SELECT DISTINCT p.produit_type
            FROM reservation_update r
            JOIN produit p ON r.res_produit = p.produit_type
            JOIN entrepot e ON r.res_entrepot = e.entrepot_id
            WHERE e.entrepot_nom = ? AND r.encours = 1 AND r.estDeposer=1 AND r.res_quantite > 0;

        `;
        db.query(query, [entrepotName], (err, results) => {
            if (err) {
                return callback(err);
            } else if (results.length > 0) {
                return callback(null, results);
            } else {
                return callback(null, []);
            }
        });
    }
    static getProduits(callback) {
        const query = `
            SELECT produit_type, produit_prix 
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
    static getEntrepotLivraison(entrepotName , callback) {
        const query = `
            SELECT p.producter_firstname, p.producter_secondname,r.res_id , r.res_quantite AS quantite_reservation, r.res_produit, r.res_producteur AS resphone  FROM reservation r JOIN producter p ON r.res_producteur = p.producter_phone  JOIN entrepot e ON r.res_entrepot = e.entrepot_id  WHERE e.entrepot_nom = ? AND r.encours = 1   AND r.estDeposer = 0;
        `;
        db.query(query, [entrepotName], (err, results) => {
            if (err) {
                return callback(err, null);
            } else if(results.length > 0){
                return callback(null, results);
            }else{
                return callback(null, []);
            }
        });
    }
    static getDemandeEntrepotLivraison(entrepotName , callback) {
        const query = `
            SELECT p.producter_firstname, p.producter_secondname,r.res_id , r.res_quantite AS quantite_reservation, r.res_produit, r.res_producteur AS resphone  FROM reservation r JOIN producter p ON r.res_producteur = p.producter_phone  JOIN entrepot e ON r.res_entrepot = e.entrepot_id  WHERE e.entrepot_nom = ? AND r.encours = 1  AND r.livraison = 1 AND r.estDeposer = 0;
        `;
        db.query(query, [entrepotName], (err, results) => {
            if (err) {
                return callback(err, null);
            } else if(results.length > 0){
                return callback(null, results);
            }else{
                return callback(null, []);
            }
        });
    }

    static getEntrepotReservationDeposer(entrepotName , callback) {
        const query = `
            SELECT p.producter_firstname, p.producter_secondname, r.res_producteur AS resphone, r.res_quantite AS quantite_reservation, r.res_produit, r.res_id  FROM reservation r JOIN producter p ON r.res_producteur = p.producter_phone  JOIN entrepot e ON r.res_entrepot = e.entrepot_id  WHERE e.entrepot_nom = ? AND r.encours = 1  AND r.estDeposer = 1;
        `;
        db.query(query, [entrepotName], (err, results) => {
            if (err) {
                return callback(err, null);
            } else if(results.length > 0){
                return callback(null, results);
            }else{
                return callback(null, []);
            }
        });
    }

    static getEntrepotReservationProducteurEnCour(Data , callback) {
        const { entrepotName, resProducteur } = Data;
        const query = `
            SELECT p.producter_firstname, p.producter_secondname, 
            r.res_quantite AS quantite_reservation, r.res_produit, r.res_id,
            DATEDIFF(DATE_ADD(r.res_datetime_validation, INTERVAL r.reservation_duree DAY), 
            CURDATE()) AS temps_restant_jours
            FROM reservation_update r JOIN producter p ON r.res_producteur = p.producter_phone
            JOIN entrepot e ON r.res_entrepot = e.entrepot_id 
            WHERE e.entrepot_nom  = ? AND r.encours = 1 AND r.res_producteur = ? AND r.res_quantite>0;
        `;
        db.query(query, [entrepotName, resProducteur], (err, results) => {
            if (err) {
                return callback(err, null);
            } else if(results.length > 0){
                return callback(null, results);
            }else{
                return callback(null, []);
            }
        });
    }

    static getEntrepotReservationExpiringToday(entrepotName , callback) {
        const query = `
            SELECT p.producter_firstname, p.producter_secondname, r.res_quantite AS quantite_reservation, r.res_produit, r.res_id, r.res_producteur AS resphone
            FROM reservation_update r 
            JOIN producter p ON r.res_producteur = p.producter_phone  JOIN entrepot e ON r.res_entrepot = e.entrepot_id 
             WHERE e.entrepot_nom = ? 
             AND r.encours = 1  AND
            DATE(DATE_ADD(r.res_datetime_validation, INTERVAL r.reservation_duree DAY)) = CURDATE();
        `;
        db.query(query, [entrepotName], (err, results) => {
            if (err) {
                return callback(err, null);
            } else if(results.length > 0){
                return callback(null, results);
            }else{
                return callback(null, []);
            }
        });
    }

    static getDistinctProducteur(entrepotName , callback) {
        const query = `
            SELECT DISTINCT 
            p.producter_firstname,
            p.producter_secondname,
            p.producter_phone
            FROM 
                reservation_update r
            JOIN 
                producter p ON r.res_producteur = p.producter_phone
            JOIN 
                entrepot e ON r.res_entrepot = e.entrepot_id
            WHERE 
                e.entrepot_nom = ? AND r.estDeposer=1 AND r.res_quantite> 0 AND r.encours = 1; 
        `;
        db.query(query, [entrepotName], (err, results) => {
            if (err) {
                return callback(err, null);
            } else if(results.length > 0){
                return callback(null, results);
            }else{
                return callback(null, []);
            }
        });
    }

    static getProduitProducer(Data , callback) {
        const { entrepotName, producerPhone } = Data;
        const query = `
            SELECT 
                r.res_produit,
                SUM(r.res_quantite) AS total_quantite  -- Quantité totale par type de produit
            FROM 
                reservation_update r
            JOIN 
                producter p ON r.res_producteur = p.producter_phone
            JOIN 
                entrepot e ON r.res_entrepot = e.entrepot_id
            WHERE 
                e.entrepot_nom = ?
                AND p.producter_phone = ? AND r.estDeposer=1 AND r.res_quantite>0 AND r.encours = 1
            GROUP BY 
                r.res_produit;
        `;
        db.query(query, [entrepotName, producerPhone], (err, results) => {
            if (err) {
                return callback(err, null);
            } else if(results.length > 0){
                return callback(null, results);
            }else{
                return callback(null, []);
            }
        });
    }

    static getProduitEntrepot(entrepotName , callback) {
        const query = `
            SELECT 
                r.res_produit AS produit,  
                SUM(r.res_quantite) AS total_quantite 
            FROM 
                reservation_update r
            JOIN 
                entrepot e ON r.res_entrepot = e.entrepot_id
            WHERE 
                e.entrepot_nom = ? AND r.estDeposer=1 AND r.res_quantite AND r.encours = 1
            GROUP BY 
                r.res_produit;
        `;
        db.query(query, [entrepotName], (err, results) => {
            if (err) {
                return callback(err, null);
            } else if(results.length > 0){
                return callback(null, results);
            }else{
                return callback(null, []);
            }
        });
    }


    static getNumberProducteurReservation(entrepotName , callback) {
        const query = `
            SELECT 
                p.producter_firstname AS firstname,
                p.producter_secondname AS secondname,
                COUNT(r.res_id) AS reservations_en_cours,
                p.producter_phone as phone

            FROM 
                reservation_update r
            JOIN 
                producter p ON r.res_producteur = p.producter_phone
            JOIN 
                entrepot e ON r.res_entrepot = e.entrepot_id
            WHERE 
                r.encours = 1 
                AND e.entrepot_nom = ? AND r.res_quantite>0
            GROUP BY 
                p.producter_firstname, p.producter_secondname, p.producter_phone
            ORDER BY 
                reservations_en_cours DESC;
        `;
        db.query(query, [entrepotName], (err, results) => {
            if (err) {
                return callback(err, null);
            } else if(results.length > 0){
                return callback(null, results);
            }else{
                return callback(null, []);
            }
        });
    }

    static updateReservationEncours(reservationId, nouvelleValeur, callback) {
        const query = `
            UPDATE reservation
            SET encours = ?
            WHERE res_id = ?;
        `;

        const query_2 = `
            UPDATE reservation_update
            SET encours = ?
            WHERE res_id = ?;
        `;
    
        db.query(query, [nouvelleValeur, reservationId], (err, results) => {
            if (err) {
                return callback(err, null);
            } else if (results.affectedRows > 0) {
                db.query(query_2, [nouvelleValeur, reservationId], (err, results) => {
                    if (err) {
                        return callback(err, null);
                    } else if (results.affectedRows > 0) {
                        const updateEntrepotProduitQuantite = `
                                    UPDATE entrepotproduit
                                    SET capacite = capacite - (SELECT res_quantite FROM reservation_update WHERE res_id = ?)
                                    WHERE entrepot_id = (SELECT res_entrepot FROM reservation_update WHERE res_id = ?) AND 
                                    produit_type = (SELECT res_produit FROM reservation_update WHERE res_id = ?)
                                `;
                
                                db.query(
                                    updateEntrepotProduitQuantite,
                                    [reservationId, reservationId, reservationId],
                                    (err, result) => {
                                        if (err) {
                                            console.error('Erreur lors de la mise à jour des quantités du produit :', err);
                                            callback(err, null);
                                        } else {
                                            
                                            // Mise à jour de la capacité totale de l'entrepôt
                                            const updateEntrepotCapacite = `
                                                UPDATE entrepot
                                                SET entrepot_capacite_total = entrepot_capacite_total + (SELECT res_quantite FROM reservation_update WHERE res_id = ?)
                                                WHERE entrepot_id = (SELECT res_entrepot FROM reservation_update WHERE res_id = ?)
                                            `;
                                            db.query(
                                                updateEntrepotCapacite,
                                                [reservationId, reservationId],  // Correction ici, on soustrait la quantité et on passe l'ID de l'entrepôt
                                                (err, result) => {
                                                    if (err) {
                                                        console.error('Erreur lors de la mise à jour de la capacité de l\'entrepôt :', err);
                                                        callback(err, null);
                                                    } else {
                                                        return callback(null, { success: true, message: 'Reservation mise à jour avec succès.' });
                                                    }
                                                }
                                            );
                                        }
                                    }
                                );
                    } else {
                        // Si aucune ligne n'a été affectée, retourner un message indiquant que l'ID n'a pas été trouvé
                        return callback(null, { success: false, message: 'Aucune réservation trouvée avec cet ID.' });
                    }
                });
            } else {
                // Si aucune ligne n'a été affectée, retourner un message indiquant que l'ID n'a pas été trouvé
                return callback(null, { success: false, message: 'Aucune réservation trouvée avec cet ID.' });
            }
        });
    }

    static updateReservationLivrer(reservationId, nouvelleValeur, callback) {
        const query = `
            UPDATE reservation
            SET estDeposer = ?
            WHERE res_id = ?;
        `;
        const query_2 = `
            UPDATE reservation_update
            SET estDeposer = ?
            WHERE res_id = ?;
        `;
    
        db.query(query, [nouvelleValeur, reservationId], (err, results) => {
            if (err) {
                return callback(err, null);
            } else if (results.affectedRows > 0) {
                // Si la mise à jour a réussi, retourner un message de succès
                db.query(query_2, [nouvelleValeur, reservationId], (err, results) => {
                    if (err) {
                        return callback(err, null);
                    } else if (results.affectedRows > 0) {
                        // Si la mise à jour a réussi, retourner un message de succès
                        return callback(null, { success: true, message: 'Reservation mise à jour avec succès.' });
                    } else {
                        // Si aucune ligne n'a été affectée, retourner un message indiquant que l'ID n'a pas été trouvé
                        return callback(null, { success: false, message: 'Aucune réservation trouvée avec cet ID.' });
                    }
                });
            } else {
                // Si aucune ligne n'a été affectée, retourner un message indiquant que l'ID n'a pas été trouvé
                return callback(null, { success: false, message: 'Aucune réservation trouvée avec cet ID.' });
            }
        });
    }
    static getEntrepotIdByName(entrepotName, callback) {
        const getEntrepotIdByNameQuery = 'SELECT `entrepot_id` FROM `entrepot` WHERE `entrepot_nom` = ?';
        db.query(getEntrepotIdByNameQuery, [entrepotName], (err, results) => {
            if (err) {
                return callback(err);
            } else if (results.length > 0) {
                return callback(null, results[0]);
            } else {
                return callback(null, null);
            }
        });
    }

    static ajoutStock (reservationData, callback) {
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


    static ModificationStock (ModificationData, callback) {
        const {
            resProducteur,
            resEntrepot,
            resProduit,
            Quantite
        } = ModificationData;
    
        const Query = `
            CALL ReduceQuantity (?, ?, ?, ?)
        `;
        // Exécution de l'insertion
        db.query(
            Query,
            [
                resProducteur,
                resEntrepot,
                resProduit,
                Quantite
            ],
            (err, result) => {
                if (err) {
                    callback(err, null);
                } else {
         
                    const updateEntrepotProduitQuantite = `
                    UPDATE entrepotproduit
                    SET capacite = capacite - ?
                    WHERE entrepot_id = ? AND produit_type = ?
                `;

                db.query(
                    updateEntrepotProduitQuantite,
                    [Quantite, resEntrepot, resProduit],
                    (err, result) => {
                        if (err) {
                            console.error('Erreur lors de la mise à jour des quantités du produit :', err);
                            callback(err, null);
                        } else {
                            // Mise à jour de la capacité totale de l'entrepôt
                            const updateEntrepotCapacite = `
                                UPDATE entrepot
                                SET entrepot_capacite_total = entrepot_capacite_total + ?
                                WHERE entrepot_id = ?
                            `;
                            db.query(
                                updateEntrepotCapacite,
                                [Quantite, resEntrepot],  // Correction ici, on soustrait la quantité et on passe l'ID de l'entrepôt
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
      

module.exports = Gerant;


