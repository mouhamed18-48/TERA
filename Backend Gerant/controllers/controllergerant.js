const Gerant = require('../models/gerant');
const bcrypt = require('bcrypt');
const crypto = require('crypto')


exports.register = (req, res) => {
    const { gerantName, gerantEntrepot, gerantId, gerantPassword } = req.body;

    Gerant.createGerant({ gerantName, gerantEntrepot, gerantId, gerantPassword }, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Error registering gerant', error: err });
        } else {
            res.status(200).json({ message: 'Gerant registered successfully' });
        }
    });
};

var ids = [];

function createRandomString() {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    let result = "";
    let length = 6;

    // Continue de générer tant que l'ID est déjà utilisé
    do {
        result = ""; // Réinitialise la chaîne avant chaque génération
        const randomArray = new Uint8Array(length);
        crypto.getRandomValues(randomArray); // Génère des valeurs aléatoires

        randomArray.forEach((number) => {
            result += chars[number % chars.length]; // Construit la chaîne aléatoire
        });
    } while (ids.includes(result));

    // Ajoute l'ID généré à la liste des IDs existants
    ids.push(result);

    return result;
}

exports.ajoutStock=(req,res)=>{
    const { resProducteur, resEntrepot, resProduit, resDatetimeValidation, estDeposer, resQuantite, encours, reservationDuree, livraison } = req.body;
    let resId = createRandomString();
    Gerant.ajoutStock({resId, resProducteur, resEntrepot, resProduit, resDatetimeValidation, estDeposer, resQuantite, encours, reservationDuree, livraison }, (err, reservation)=> {
        if(err){
            res.status(500).json({message:'Error registering reservation'});
        }else{
            res.status(200).json({message:'Reservation registered successfully', reservation});
        }
    });
};

exports.ModificationStock=(req,res)=>{
    const { resProducteur, resEntrepot, resProduit, Quantite } = req.body;
    Gerant.ModificationStock({resProducteur, resEntrepot, resProduit, Quantite}, (err, result)=> {
        if(err){
            res.status(500).json({message:'Error registering reservation'});
        }else{
            res.status(200).json({message:'Reservation registered successfully', 'result': result});
        }
    });
};

exports.getEntrepotIdByName = (req, res) => {
    const { entrepotName } = req.body;

    Gerant.getEntrepotIdByName(entrepotName, (err, entrepot) => {
        if (err) {
            res.status(500).json({ message: 'Error' });
        } else if (entrepot) {
            res.status(200).json({ message: 'Entrepot found', entrepot_id: entrepot.entrepot_id });
        } else {
            res.status(404).json({ message: 'Entrepot not found' });
        }
    });
};




exports.login = (req, res) => {
    const { gerantId, gerantPassword } = req.body;

    Gerant.findById({ gerantId, gerantPassword }, (err, gerant) => {
        if(err){
            res.status(500).json({message:'Error Logging in'});
        }else if(gerant){
            res.status(200).json({message:'Login Success', gerant});
        }else{
            res.status(401).json({message:'Invalid credentials'});
        }
    });
};

exports.getEntrepotCapacityByName = (req, res) => {
    const { entrepotName } = req.body;

    Gerant.getEntrepotCapacityByName(entrepotName, (err, capacity) => {
        if (err) {
            res.status(500).json({ message: 'Error' });
        } else if (capacity) {
            res.status(200).json({ message: 'Capacity found', "capacity": capacity[0] });
        } else {
            res.status(404).json({ message: 'Capacity not found' });
        }
    });
};

exports.getNumberReservationExpiredIn7Day = (req, res) => {
    const { entrepotName } = req.body;
  
    Gerant.getNumberReservationExpiredIn7Day(entrepotName, (err, number) => {
      if (err) {
        res.status(500).json({ message: 'Error' });
      } else if (number && number.length > 0) {
        res.status(200).json({ message: 'number found', number:number[0] });
      } else {
        res.status(404).json({ message: 'No number found' });
      }
    });
  };

  exports.getDistinctProductTypes = (req, res) => {
    const { entrepotName } = req.body;

    Gerant.getDistinctProductTypes({ entrepotName }, (err, productTypes) => {
        if (err) {
            return res.status(500).json({ message: 'Error', error: err.message });
        } else if (productTypes.length > 0) {
            return res.status(200).json({ message: 'Product types found', productTypes });
        } else {
            return res.status(404).json({ message: 'No product types found for this entrepot' });
        }
    });
    
};

exports.getProduits = (req, res) => {
    Gerant.getProduits((err, produits) => {
        if (err) {
            res.status(500).json({ message: 'Error retrieving products', error: err });
        } else if(produits){
            res.status(200).json({message:'Produit', produits});
        }else{
          res.status(401).json({message:"Pas d'infos"});
        }
    });
  };

  exports.getEntrepotLivraison = (req, res) => {
    const { entrepotName } = req.body;

    Gerant.getEntrepotLivraison( entrepotName , (err, Livraisons) => {
        if (err) {
            return res.status(500).json({ message: 'Error', error: err.message });
        } else if (Livraisons.length > 0) {
            return res.status(200).json({ message: 'Livraison found', Livraisons });
        } else {
            return res.status(404).json({ message: 'No livraison found for this entrepot' });
        }
    });
    
};
exports.getDemandeEntrepotLivraison = (req, res) => {
    const { entrepotName } = req.body;

    Gerant.getDemandeEntrepotLivraison( entrepotName , (err, Livraisons) => {
        if (err) {
            return res.status(500).json({ message: 'Error', error: err.message });
        } else if (Livraisons.length > 0) {
            return res.status(200).json({ message: 'Livraison found', Livraisons });
        } else {
            return res.status(404).json({ message: 'No livraison found for this entrepot' });
        }
    });
    
};

exports.getEntrepotReservationDeposer = (req, res) => {
    const { entrepotName } = req.body;

    Gerant.getEntrepotReservationDeposer( entrepotName , (err, Livraisons) => {
        if (err) {
            return res.status(500).json({ message: 'Error', error: err.message });
        } else if (Livraisons.length > 0) {
            return res.status(200).json({ message: 'Livraison found', Livraisons });
        } else {
            return res.status(404).json({ message: 'No livraison found for this entrepot' });
        }
    });
    
};

exports.getEntrepotReservationProducteurEnCour = (req, res) => {
    const { entrepotName, resProducteur } = req.body;

    Gerant.getEntrepotReservationProducteurEnCour( { entrepotName, resProducteur } , (err, Livraisons) => {
        if (err) {
            return res.status(500).json({ message: 'Error', error: err.message });
        } else if (Livraisons.length > 0) {
            return res.status(200).json({ message: 'Livraison found', Livraisons });
        } else {
            return res.status(404).json({ message: 'No livraison found for this entrepot' });
        }
    });
    
};

exports.getEntrepotReservationExpiringToday = (req, res) => {
    const { entrepotName } = req.body;

    Gerant.getEntrepotReservationExpiringToday( entrepotName , (err, Livraisons) => {
        if (err) {
            return res.status(500).json({ message: 'Error', error: err.message });
        } else if (Livraisons.length > 0) {
            return res.status(200).json({ message: 'Livraison found', Livraisons });
        } else {
            return res.status(404).json({ message: 'No livraison found for this entrepot' });
        }
    });
    
};

exports.getDistinctProducteur = (req, res) => {
    const { entrepotName } = req.body;

    Gerant.getDistinctProducteur( entrepotName , (err, Producteurs) => {
        if (err) {
            return res.status(500).json({ message: 'Error', error: err.message });
        } else if (Producteurs.length > 0) {
            return res.status(200).json({ message: 'Producter found', Producteurs });
        } else {
            return res.status(404).json({ message: 'No Producter found for this entrepot' });
        }
    });
};

exports.getProduitProducer = (req, res) => {
    const { entrepotName, producerPhone } = req.body;

    Gerant.getProduitProducer( {entrepotName, producerPhone} , (err, Produits) => {
        if (err) {
            return res.status(500).json({ message: 'Error', error: err.message });
        } else if (Produits.length > 0) {
            return res.status(200).json({ message: 'Products found', Produits });
        } else {
            return res.status(404).json({ message: 'No Product found for this producer' });
        }
    });
};

exports.getProduitEntrepot = (req, res) => {
    const { entrepotName } = req.body;

    Gerant.getProduitEntrepot( entrepotName , (err, Produits) => {
        if (err) {
            return res.status(500).json({ message: 'Error', error: err.message });
        } else if (Produits.length > 0) {
            return res.status(200).json({ message: 'Produits found', Produits });
        } else {
            return res.status(404).json({ message: 'No Produit found for this entrepot' });
        }
    });
};
exports.getNumberProducteurReservation = (req, res) => {
    const { entrepotName } = req.body;

    Gerant.getNumberProducteurReservation( entrepotName , (err, NumberReservation) => {
        if (err) {
            return res.status(500).json({ message: 'Error', error: err.message });
        } else if (NumberReservation.length > 0) {
            return res.status(200).json({ message: 'Number found', NumberReservation });
        } else {
            return res.status(404).json({ message: 'Vide' });
        }
    });
};

// Contrôleur qui met à jour le champ encours d'une réservation
exports.updateReservationEncours = (req, res) => {
    // Récupère les données du corps de la requête
    const { reservationId, nouvelleValeur } = req.body;

    // Appel de la méthode pour mettre à jour encours avec l'ID de la réservation et la nouvelle valeur
    Gerant.updateReservationEncours(reservationId, nouvelleValeur, (err, result) => {
        if (err) {
            // Si une erreur se produit, renvoie un statut 500 avec le message d'erreur
            return res.status(500).json({ message: 'Erreur lors de la mise à jour', error: err.message });
        } else if (result.success) {
            // Si la mise à jour a réussi, renvoie un statut 200 avec un message de succès
            return res.status(200).json({ message: 'Réservation mise à jour avec succès' });
        } else {
            // Si aucune réservation n'a été trouvée pour l'ID fourni
            return res.status(404).json({ message: 'Aucune réservation trouvée avec cet ID' });
        }
    });
};

exports.updateReservationLivrer = (req, res) => {
    // Récupère les données du corps de la requête
    const { reservationId, nouvelleValeur } = req.body;

    // Appel de la méthode pour mettre à jour encours avec l'ID de la réservation et la nouvelle valeur
    Gerant.updateReservationLivrer(reservationId, nouvelleValeur, (err, result) => {
        if (err) {
            // Si une erreur se produit, renvoie un statut 500 avec le message d'erreur
            return res.status(500).json({ message: 'Erreur lors de la mise à jour', error: err.message });
        } else if (result.success) {
            // Si la mise à jour a réussi, renvoie un statut 200 avec un message de succès
            return res.status(200).json({ message: 'Réservation mise à jour avec succès' });
        } else {
            // Si aucune réservation n'a été trouvée pour l'ID fourni
            return res.status(404).json({ message: 'Aucune réservation trouvée avec cet ID' });
        }
    });
};
