const express= require('express')
const router =express.Router();
const produitController=require('./controller/controller')


router.post('/createProduitProducteur', produitController.produitProducteur);
router.post('/getProduitEntrepots', produitController.getproduitEntrepot);
router.post('/getProduitInfos', produitController.getproduitInfos);
router.post('/getProduits', produitController.getProduits);
router.post('/createProduitProducteur', produitController.produitProducteur);
router.post('/registerReservation', produitController.registerReservation);
router.post('/getDistinctProductTypes', produitController.getDistinctProductTypes);
router.post('/getQuantitiesByEntrepot', produitController.getQuantitiesByEntrepot);
router.post('/getProductsWithQuantities', produitController.getProductsWithQuantities);
router.post('/registerProduction', produitController.registerProduction);
router.post('/checkProductionExists', produitController.checkProduction);
router.post('/getNumberProduits', produitController.getNombreProduitsReserve);

module.exports=router;