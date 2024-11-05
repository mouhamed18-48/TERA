const Produit =require('../models/produit')
const crypto = require('crypto'); 

exports.getproduitEntrepot=(req,res)=>{
    const { entrepotId } = req.body;

    Produit.getProduitEntrepot({ entrepotId }, (err, produits)=> {
        if(err){
            res.status(500).json({message:'Error'});
        }else if(produits){
            res.status(200).json({message:"Produit de l'entrepot", produits});
        }else{
            res.status(401).json({message:'Pas de produits'});
        }
    });

};

exports.getProductsWithQuantities = (req, res) => {
    const { producterPhone } = req.body;
  
    Produit.getProductsWithQuantities(producterId, (err, products) => {
      if (err) {
        res.status(500).json({ message: 'Error' });
      } else if (products && products.length > 0) {
        res.status(200).json({ message: 'Products found', products });
      } else {
        res.status(404).json({ message: 'No products found' });
      }
    });
  };


exports.getproduitInfos=(req,res)=>{
    const { produitType } = req.body;

    Produit.getProduitInfos({ produitType }, (err, produit)=> {
        if(err){
            res.status(500).json({message:'Error'});
        }else{
            res.status(200).json({message:"Informations du produi", produit});
        }
    });

};

exports.getProduits = (req, res) => {
    Produit.getProduits((err, result) => {
        if (err) {
            res.status(500).json({ message: 'Error retrieving products', error: err });
        } else {
            res.status(200).json(result);
        }
    });
};

exports.getProductsWithQuantities = (req, res) => {
    const { producterPhone } = req.body;
  
    Produit.getProductsWithQuantities(producterPhone, (err, products) => {
      if (err) {
        res.status(500).json({ message: 'Error' });
      } else if (products && products.length > 0) {
        res.status(200).json({ message: 'Products found', products });
      } else {
        res.status(404).json({ message: 'No products found' });
      }
    });
  };

  exports.produitProducteur=(req,res)=>{
    const { producterPhone, produits } = req.body;

    Produit.createProduitProducteur({ producterPhone, produits }, (err, produit)=> {
        if(err){
            res.status(500).json({message:"Erreur d'enregistrement des produit"});
        }else{
            res.status(200).json({message:'Enregistrement reussi', produit});
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

exports.registerReservation=(req,res)=>{
    const { resProducteur, resEntrepot, resProduit, resDatetimeValidation, estDeposer, resQuantite, encours, reservationDuree, livraison } = req.body;
    let resId = createRandomString();
    Produit.createReservation({resId, resProducteur, resEntrepot, resProduit, resDatetimeValidation, estDeposer, resQuantite, encours, reservationDuree, livraison }, (err, reservation)=> {
        if(err){
            res.status(500).json({message:'Error registering reservation'});
        }else{
            res.status(200).json({message:'Reservation registered successfully', reservation});
        }
    });
};

exports.registerProduction = (req, res) => {
    // Extraction des données du corps de la requête
    const { nombreChamps, adresse, producteurPhone } = req.body;

    // Appel de la méthode createProduction du modèle avec les données fournies
    Produit.createProduction({ nombreChamps, adresse, producteurPhone }, (err, result) => {
        if (err) {
            // En cas d'erreur lors de l'enregistrement dans la base de données
            res.status(500).json({ message: 'Error registering production', error: err });
        } else {
            // Réponse de succès
            res.status(200).json({ message: 'Production registered successfully', production: result });
        }
    });
};

exports.checkProduction = (req, res) => {
    // Récupérer le numéro de téléphone du producteur depuis la requête (GET ou POST)
    const { producteurPhone } = req.body; // Utilisez `req.query` si les données viennent de l'URL dans le cas d'une requête GET

    // Vérification de l'existence de la production
    Produit.checkProductionExists(producteurPhone, (err, exists) => {
        if (err) {
            // Gérer l'erreur de requête SQL ou autre erreur inattendue
            res.status(500).json({ message: 'Error checking production existence', error: err });
        } else if (exists) {
            // Retourner un succès si la production existe
            res.status(200).json({ message: 'Production exists for this producer', exists: true });
        } else {
            // Retourner une réponse si la production n'existe pas
            res.status(200).json({ message: 'does not exist for this producer', exists: false });
        }
    });
};



exports.getDistinctProductTypes=(req, res)=>{
    const {resProducter}=req.body;
    Produit.getDistinctProductTypes({resProducter}, (err, productTypes) => {
    if (err) {
        return res.status(500).json({ message: 'Error', error: err.message });
    } else if (productTypes.length > 0) {
        return res.status(200).json({ message: 'Product types found', productTypes });
    } else {
        return res.status(404).json({ message: 'No product types found for this producer' });
    }
});
};

exports.getQuantitiesByEntrepot = (req, res) => {
    const { producterPhone, produitType } = req.body;
  
    Produit.getQuantitiesByEntrepot({producterPhone, produitType}, (err, quantities) => {
      if (err) {
        res.status(500).json({ message: 'Error' });
      } else if (quantities && quantities.length > 0) {
        res.status(200).json({ message: 'Quantities found', quantities });
      } else {
        res.status(404).json({ message: 'No quantities found' });
      }
    });
  };

  exports.getNombreProduitsReserve = (req, res) => {
    // Récupérer les paramètres depuis la requête
    const { producterPhone, entrepotName } = req.body; // Utilisez req.query si vous utilisez GET
  
    // Appeler la méthode du modèle pour obtenir le nombre de produits réservés
    Produit.getNombreProduitsReserve({ producterPhone, entrepotName }, (err, nombreProduits) => {
      if (err) {
        // Gérer les erreurs
        res.status(500).json({ message: 'Erreur lors de la récupération des réservations', error: err });
      } else {
        // Réponse en cas de succès
        res.status(200).json({ message: 'Nombre de produits récupéré avec succès', nombreProduits });
      }
    });
  };
  