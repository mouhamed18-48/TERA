const db = require('../configuration/database');
const bcrypt = require('bcrypt');

class Consommateur {


    static createConsommateur(consomData, callback) {
        const { consommateurFirstName, consommateurSecondName, consommateurPhone, consommateurPassword } = consomData;
        
        // Hacher le mot de passe avant de le sauvegarder dans la base de données
        bcrypt.hash(consommateurPassword, 10, (err, hashedPassword) => {
            if (err) return callback(err);

            const query = `
                INSERT INTO consommateur (consommateur_firstname, consommateur_secondname, consommateur_phone, consommateur_password)
                VALUES (?, ?, ?, ?)
            `;
            db.query(query, [consommateurFirstName, consommateurSecondName, consommateurPhone, hashedPassword], (err, result) => {
                if (err) return callback(err);
                callback(null, result);
            });
        });
    }
    

    static findByPhone(consomData, callback) {
        const { consommateurPhone, consommateurPassword } = consomData;
        const query = `SELECT * FROM consommateur WHERE consommateur_phone = ?`;
        db.query(query, [consommateurPhone], (err, results) => {
            if(err){
                callback(err);
            }else if(results.length>0){
                const consommateur = results[0];
                bcrypt.compare(consommateurPassword, consommateur.consommateur_password, (err, result)=>{
                    if(result){
                        callback(null, consommateur);
                    }else{
                        callback(null, null);
                    }
                });
            }else{
                callback(null, null);
            }
        })
    }
    // SELECT DISTINCT(e.entrepot_nom) FROM entrepotproduit e1 JOIN entrepot e ON e1.entrepot_id = e.entrepot_id WHERE e1.capacite > 0;


    static getEntrepot(callback){
        const query = `SELECT DISTINCT(e.entrepot_nom), e.entrepot_id FROM entrepotproduit e1 JOIN entrepot e ON e1.entrepot_id = e.entrepot_id WHERE e1.capacite > 0;`
        db.query(query, (err, results)=> {
            if(err){
                callback(err);
            }else if(results.length > 0){
                callback(null, results)
            }else{
                callback(null, null);
            }
        })
    }

    static getDistinctProductTypes(entrepotData, callback) {

        const { entrepotId } = entrepotData;
        const query = `
            SELECT DISTINCT e.produit_type FROM entrepotproduit e WHERE e.capacite > 0 AND e.entrepot_id = ?;
        `;
        db.query(query, [entrepotId], (err, results) => {
            if (err) {
                return callback(err);
            } else if (results.length > 0) {
                return callback(null, results);
            } else {
                return callback(null, []);
            }
        });
    }
    // SELECT p.produit_type, SUM(e.capacite) AS quantite , p.produit_prix FROM entrepotproduit e JOIN produit p ON e.produit_type = p.produit_type GROUP BY  p.produit_type;


    static getProduitsDispo(callback) {
        const query = `
          SELECT p.produit_type, SUM(e.capacite) AS quantite , p.produit_prix FROM entrepotproduit e JOIN produit p ON e.produit_type = p.produit_type WHERE e.capacite >0 GROUP BY  p.produit_type;
        `;
        db.query(query, (err, results) => {
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

      static getProduitsDispoEntrepot(id , callback) {
        const query = `
          SELECT p.produit_type, SUM(e.capacite) AS quantite , p.produit_prix FROM entrepotproduit e JOIN produit p ON e.produit_type = p.produit_type WHERE e.capacite >0 AND e.entrepot_id= ? GROUP BY  p.produit_type;
        `;
        db.query(query,[id], (err, results) => {
          if (err) {
            return callback(err);
          } else if (results.length > 0) {
            return callback(null, results);
          } else {
            return callback(null, []);
          }
        });
      }

      static getVenteEncour(phone , callback) {
        const query = `
            SELECT vente_id, 
            vente_produit, 
            vente_quantite, 
            vente_prix, 
            (4-DATEDIFF(CURDATE(), vente_datetime_validation)) AS temps_livraison 
            FROM vente 
            WHERE vente_encour = 1 AND vente_consommateur = ?;
        `;
        db.query(query,[phone], (err, results) => {
          if (err) {
            return callback(err);
          } else if (results.length > 0) {
            return callback(null, results);
          } else {
            return callback(null, []);
          }
        });
      }

      static getVentePasEncour(phone , callback) {
        const query = `
            SELECT 
                vente_id, 
                vente_produit, 
                vente_quantite, 
                vente_prix, 
                DATEDIFF(CURDATE(), DATE_ADD(vente_datetime_validation, INTERVAL 4 DAY)) AS temps_livraison 
            FROM 
                vente 
            WHERE 
                vente_encour = 0
                AND vente_consommateur =?;
        `;
        db.query(query,[phone], (err, results) => {
          if (err) {
            return callback(err);
          } else if (results.length > 0) {
            return callback(null, results);
          } else {
            return callback(null, []);
          }
        });
      }

      static createVente(venteData, callback) {
        const {
            venteId,
            venteProduit,
            venteQuantite,
            ventePrix,
            venteEncour,
            venteDatetimeValidation,
            venteConsommateur,
            addresse,
            numero
        } = venteData;

        
    
        const insertVenteQuery = `
            INSERT INTO vente(vente_id, vente_produit, vente_quantite, vente_prix, vente_encour, vente_datetime_validation,vente_consommateur, addresse, numero) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        `;

        
    
        // Exécution de l'insertion
        db.query(
            insertVenteQuery,
            [
                venteId,
                venteProduit,
                venteQuantite,
                ventePrix,
                venteEncour,
                venteDatetimeValidation,
                venteConsommateur,
                addresse,
                numero
            ],
            (err, result) => {
                if (err) {
                    callback(err, null);
                } else {
                    callback(null, result);
                }
            }
        );
    }


}

module.exports = Consommateur;