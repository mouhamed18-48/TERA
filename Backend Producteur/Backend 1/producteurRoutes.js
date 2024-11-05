const express= require('express')
const router =express.Router();
const producteurController=require('./controllers/controllerproducteur')

router.post('/registerProducteur', producteurController.register);
router.post('/loginProducteur', producteurController.login);

module.exports=router;