const Consommateur = require('../models/consommateur');
const bcrypt = require('bcrypt');
const crypto = require('crypto'); 


exports.register = (req, res) => {
    const { consommateurFirstName, consommateurSecondName, consommateurPhone, consommateurPassword } = req.body;
    
    Consommateur.createConsommateur({ consommateurFirstName, consommateurSecondName, consommateurPhone, consommateurPassword }, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Error registering gerant', error: err });
        } else {
            res.status(200).json({ message: 'Gerant registered successfully' });
        }
    });
};



exports.login = (req, res) => {
    const { consommateurPhone, consommateurPassword } = req.body;
    console.log(consommateurPhone, consommateurPassword)
    Consommateur.findByPhone({ consommateurPhone, consommateurPassword }, (err, consommateur) => {
        if(err){
            res.status(500).json({message:'Error Logging in'});
        }else if(consommateur){
            res.status(200).json({message:'Login Success', consommateur});
        }else{
            res.status(401).json({message:'Invalid credentials'});
        }
    });
};



exports.getEntrepot = (req, res) => {
    Consommateur.getEntrepot((err, entrepots)=>{
        if(err){
            res.status(500).json({message:'erreur de chargement '});
        }else if (entrepots){
            res.status(200).json({message:'les entrepots disponible', entrepots});
        }else{
            res.status(401).json({message:"Pas d'entrepots"});
        }
    });
};

exports.getDistinctProductTypes=(req, res)=>{
    const {entrepotId}=req.body;
    Consommateur.getDistinctProductTypes({entrepotId}, (err, productTypes) => {
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
    Consommateur.getProduits((err, result) => {
        if (err) {
            res.status(500).json({ message: 'Error retrieving products', error: err });
        } else {
            res.status(200).json(result);
        }
    });
};

exports.getProduitsDispo = (req, res) => {
    Consommateur.getProduitsDispo((err, products) => {
        if (err) {
            res.status(500).json({ message: 'Error' });
        } else if (products && products.length > 0) {
            res.status(200).json({ message: 'Products found', products });
        } else {
            res.status(404).json({ message: 'No products found' });
        }
    });
};

exports.getProduitsDispoEntrepot = (req, res) => {
    const {id}=req.body;
    Consommateur.getProduitsDispoEntrepot(id, (err, products) => {
        if (err) {
            res.status(500).json({ message: 'Error' });
        } else if (products && products.length > 0) {
            res.status(200).json({ message: 'Products found', products });
        } else {
            res.status(404).json({ message: 'No products found' });
        }
    });
    
};

exports.getVenteEncour = (req, res) => {
    const {phone}=req.body;
    console.log(phone);
    Consommateur.getVenteEncour(phone, (err, ventes) => {
        if (err) {
            res.status(500).json({ message: 'Error' });
        } else if (ventes && ventes.length > 0) {
            res.status(200).json({ message: 'vente found', ventes });
        } else {
            res.status(404).json({ message: 'No vente found' });
        }
    });
    
};

exports.getVentePasEncour = (req, res) => {
    const {phone}=req.body;
    console.log(phone);
    Consommateur.getVentePasEncour(phone, (err, ventes) => {
        if (err) {
            res.status(500).json({ message: 'Error' });
        } else if (ventes && ventes.length > 0) {
            res.status(200).json({ message: 'vente found', ventes });
        } else {
            res.status(404).json({ message: 'No vente found' });
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


exports.createVente=(req,res)=>{
    const {
        venteProduit,
        venteQuantite,
        ventePrix,
        venteEncour,
        venteDatetimeValidation,
        venteConsommateur,
        addresse,
        numero
     } = req.body;

     let venteId = createRandomString();
     

    Consommateur.createVente({ venteId , venteProduit, venteQuantite, ventePrix, venteEncour, venteDatetimeValidation, venteConsommateur , addresse, numero }, (err, vente)=> {
        if(err){
            console.log(createRandomString());
            res.status(500).json({message:'Error registering reservation'});
        }else{
            res.status(200).json({message:'Reservation registered successfully', vente});
        }
    });
};
