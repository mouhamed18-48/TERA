const Entrepot = require('../models/entrepotProche')

exports.getEntrepot=(req, res)=>{

    Entrepot.getAllEntrepots((err, entrepots)=>{
        if(err){
            res.status(500).json({message:'Error'});
        }else if(entrepots){
            res.status(200).json({message:'Entrepots', entrepots});
        }else{
            res.status(401).json({message:"Pas d'entrepts"});
        }
    })
};
exports.getEntrepotIdByName = (req, res) => {
    const { entrepotName } = req.body;

    Entrepot.getEntrepotIdByName(entrepotName, (err, entrepot) => {
        if (err) {
            res.status(500).json({ message: 'Error' });
        } else if (entrepot) {
            res.status(200).json({ message: 'Entrepot found', entrepot_id: entrepot.entrepot_id });
        } else {
            res.status(404).json({ message: 'Entrepot not found' });
        }
    });
};


exports.getNearestEntrepot = (req, res) => {
    const { userLatitude, userLongitude, producterPhone } = req.body;


    Entrepot.getNearestEntrepot({ userLatitude, userLongitude, producterPhone }, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Error retrieving nearest entrepot', error: err });
        } else if (result.length > 0) {
            res.status(200).json({ message: 'Nearest entrepot found', entrepot: result[0] });
        } else {
            res.status(404).json({ message: 'No entrepot found' });
        }
    });
};

exports.getReservedProductsEntrepot = (req, res) => {
    const { resProducteur, resEntrepot } = req.body;

    Entrepot.getReservedProductsEntrepot({resProducteur, resEntrepot}, (err, products) => {
        if (err) {
            res.status(500).json({ message: 'w' });
        } else if (products.length > 0) {
            res.status(200).json({ message: 'Products found', products });
        } else {
            res.status(404).json({ message: 'No products found for this producer in the given entrepot' });
        }
    });
};

exports.getProductDetailsByEntrepot = (req, res) => {
    const { producterPhone } = req.body;

    Entrepot.getProductDetailsByEntrepot(producterPhone, (err, productDetails) => {
        if (err) {
            res.status(500).json({ message: 'Error', error: err.message });
        } else if (productDetails.length > 0) {
            res.status(200).json({ message: 'Product details found', productDetails });
        } else {
            res.status(404).json({ message: 'No product details found for this producer' });
        }
    });
};

exports.getEntrepotQuantiteAndProduitForProducteur = (req, res) => {
    const { producterPhone } = req.body;

    Entrepot.getEntrepotQuantiteAndProduitForProducteur(producterPhone, (err, reservations) => {
        if (err) {
            res.status(500).json({ message: 'Error', error: err });
        } else if (reservations.length > 0) {
            res.status(200).json({ message: 'Reservations found', reservations });
        } else {
            res.status(404).json({ message: 'No reservations found for this producer' });
        }
    });
};


