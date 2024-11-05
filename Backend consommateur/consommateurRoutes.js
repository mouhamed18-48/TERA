const express= require('express')
const router =express.Router();
const consommateurController=require('./controllers/controllerconsommateur')

router.post('/registerConsommateur', consommateurController.register);
router.post('/loginConsommateur', consommateurController.login);
router.post('/getEntrepot', consommateurController.getEntrepot);
router.post('/getDistinctProductTypes', consommateurController.getDistinctProductTypes);
router.post('/getProduitsDispo', consommateurController.getProduitsDispo);
router.post('/getProduitsDispoEntrepot', consommateurController.getProduitsDispoEntrepot);
router.post('/createVente', consommateurController.createVente); 
router.post('/getProduitsInfo', consommateurController.getProduits); 
router.post('/getVenteEncour', consommateurController.getVenteEncour); 
router.post('/getVentePasEncour', consommateurController.getVentePasEncour); 

module.exports=router;


