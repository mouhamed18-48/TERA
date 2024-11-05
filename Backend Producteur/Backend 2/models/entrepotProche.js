const db=require('../configuration/database');



class Entrepot {

    

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

    // Méthode pour récupérer tous les entrepôts
    static getAllEntrepots(callback) {
        const query = `
            SELECT entrepot_id, contact, entrepot_nom, entrepot_latitude, entrepot_longitude, entrepot_capacite_total
            FROM entrepot WHERE entrepot.entrepot_capacite_total > 0
        `;
        db.query(query, (err, entrepots) => {
            if (err) {
                return callback(err, null);
            }else if(entrepots.length > 0){
                callback(null, entrepots);
            }else{
                callback(null, null);
            }
            
        });
    }

    static getNearestEntrepot(userEntrepotData, callback) {
        const { userLatitude, userLongitude, producterPhone } = userEntrepotData;
        const query = `
            SELECT 
                e.entrepot_nom,
                e.entrepot_capacite_total,
                COUNT(DISTINCT r.res_produit) AS nombre_produits,
                (
                    6371 * ACOS(
                        COS(RADIANS(?)) * COS(RADIANS(e.entrepot_latitude)) * 
                        COS(RADIANS(e.entrepot_longitude) - RADIANS(?)) + 
                        SIN(RADIANS(?)) * SIN(RADIANS(e.entrepot_latitude))
                    )
                ) AS distance_km
            FROM 
                entrepot e
            LEFT JOIN 
                reservation_update r ON e.entrepot_id = r.res_entrepot AND r.res_producteur = ? AND r.res_quantite>0
            GROUP BY 
                e.entrepot_id
            ORDER BY 
                distance_km ASC
            LIMIT 1;
        `;

        db.query(query, [userLatitude, userLongitude, userLatitude, producterPhone], (err, result) => {
            if (err) {
                return callback(err, null);
            } else {
                return callback(null, result);
            }
        });
    }

    static getReservedProductsEntrepot(reservationData, callback) {

        const { resProducteur, resEntrepot } = reservationData;
        const getReservedProductsQuery = ` 
            SELECT p.produit_type, SUM(r.res_quantite) AS total_quantite,
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
            JOIN entrepot e ON e.entrepot_id = r.res_entrepot
            WHERE r.res_producteur = ? AND e.entrepot_nom = ? AND r.encours=1 AND r.res_quantite>0
            GROUP BY p.produit_type;
        `;
        db.query(getReservedProductsQuery, [resProducteur, resEntrepot], (err, results) => {
            if (err) {
                return callback(err);
            } else {
                return callback(null, results);
            }
        });
    }

    // SELECT vente_id, vente_produit, vente_quantite, vente_prix, DATEDIFF(4, DATEDIFF(CURDATE(), vente_datetime_validation)) as temps_livraison FROM vente WHERE vente_encour = 1;

    static getProductDetailsByEntrepot(producterPhone, callback) {
        const getProductDetailsQuery = `
            SELECT 
                r.res_entrepot AS entrepot_id,
                e.entrepot_nom AS entrepot_name,
                COUNT(DISTINCT r.res_produit) AS distinct_product_count,
                SUM(r.res_quantite) AS total_quantity
            FROM 
                reservation_update r
            JOIN 
                entrepot e ON r.res_entrepot = e.entrepot_id
            WHERE 
                r.res_producteur = ? AND r.encours = 1 AND r.res_quantite>0
            GROUP BY 
                r.res_entrepot, e.entrepot_nom;
        `;
        
        db.query(getProductDetailsQuery, [producterPhone], (err, results) => {
            if (err) {
                return callback(err);
            } else if (results.length > 0) {
                return callback(null, results);
            } else {
                return callback(null, []);
            }
        });
    }

    static getEntrepotQuantiteAndProduitForProducteur(producterPhone, callback) {
        const getEntrepotQuantiteAndProduitQuery = `
            SELECT 
                e.entrepot_nom AS entrepot_name,
                r.res_quantite AS quantite,
                p.produit_type AS produit_type,
                DATEDIFF(DATE_ADD(r.res_datetime_validation, INTERVAL r.reservation_duree DAY), CURDATE()) AS temps_restant_jours
            FROM 
                reservation r
            JOIN 
                entrepot e ON r.res_entrepot = e.entrepot_id
            JOIN 
                produit p ON r.res_produit = p.produit_type
            WHERE 
                r.res_producteur = ?
                AND r.encours = 1
            ORDER BY 
                r.res_datetime_validation DESC;

        `;
    
        db.query(getEntrepotQuantiteAndProduitQuery, [producterPhone], (err, results) => {
            if (err) {
                return callback(err);
            } else {
                return callback(null, results);
            }
        });
    }



    

    
    
}
module.exports = Entrepot;