const Producteur = require('../models/producteur');
const bcrypt = require('bcrypt');


exports.register = (req, res) => {
    const { producterFirstName, producterSecondName, producterPhone, producterPassword } = req.body;
    Producteur.createProducter({ producterFirstName, producterSecondName, producterPhone, producterPassword }, (err, result) => {
        if (err) {
            res.status(500).json({ message: 'Error registering gerant', error: err });
        } else {
            res.status(200).json({ message: 'Gerant registered successfully' });
        }
    });
};



exports.login = (req, res) => {
    const { producterPhone, producterPassword } = req.body;

    Producteur.findByPhone({ producterPhone, producterPassword }, (err, producter) => {
        if(err){
            res.status(500).json({message:'Error Logging in'});
        }else if(producter){
            res.status(200).json({message:'Login Success', producter});
        }else{
            res.status(401).json({message:'Invalid credentials'});
        }
    });
};