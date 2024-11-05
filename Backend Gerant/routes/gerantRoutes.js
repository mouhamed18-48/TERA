const express= require('express')
const router =express.Router();
const gerantController=require('../controllers/controllergerant')

router.post('/createGerant', gerantController.register);
router.post('/loginGerant', gerantController.login);
router.post('/getEntrepotCapacityByName', gerantController.getEntrepotCapacityByName);
router.post('/getNumberReservationExpiredIn7Day', gerantController.getNumberReservationExpiredIn7Day);
router.post('/getDistinctProductTypes', gerantController.getDistinctProductTypes);
router.post('/getProduits', gerantController.getProduits);
router.post('/getEntrepotLivraison', gerantController.getEntrepotLivraison);
router.post('/getDemandeEntrepotLivraison', gerantController.getDemandeEntrepotLivraison);
router.post('/getEntrepotReservationDeposer', gerantController.getEntrepotReservationDeposer);
router.post('/getEntrepotReservationProducteurEnCour', gerantController.getEntrepotReservationProducteurEnCour);
router.post('/getDistinctProducteur', gerantController.getDistinctProducteur);
router.post('/getProduitProducer', gerantController.getProduitProducer);
router.post('/getProduitEntrepot', gerantController.getProduitEntrepot);
router.post('/getNumberProducteurReservation', gerantController.getNumberProducteurReservation);
router.post('/updateReservationEncours', gerantController.updateReservationEncours);
router.post('/updateReservationLivrer', gerantController.updateReservationLivrer);
router.post('/getEntrepotReservationExpiringToday', gerantController.getEntrepotReservationExpiringToday);
router.post('/ajoutStock', gerantController.ajoutStock);
router.post('/ModificationStock', gerantController.ModificationStock);
router.post('/getEntrepotIdByName', gerantController.getEntrepotIdByName); 

module.exports=router;