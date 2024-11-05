const express= require('express')
const router =express.Router();
const entrepotController=require('./controller/controller')


router.post('/getAllEntrepot', entrepotController.getEntrepot);
router.post('/getEntrepotIdByName', entrepotController.getEntrepotIdByName); 
router.post('/getNearestEntrepot', entrepotController.getNearestEntrepot);
router.post('/getReservedProductsEntrepot', entrepotController.getReservedProductsEntrepot);
router.post('/getProductDetailsByEntrepot', entrepotController.getProductDetailsByEntrepot);
router.post('/getEntrepotQuantiteAndProduitForProducteur', entrepotController.getEntrepotQuantiteAndProduitForProducteur);
module.exports=router;