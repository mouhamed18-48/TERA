const db = require('../configuration/database');
const bcrypt = require('bcrypt');

class Producteur {


    static createProducter(prodData, callback) {
        const { producterFirstName, producterSecondName, producterPhone, producterPassword } = prodData;
        
        // Hacher le mot de passe avant de le sauvegarder dans la base de données
        bcrypt.hash(producterPassword, 10, (err, hashedPassword) => {
            if (err) return callback(err);

            const query = `
                INSERT INTO producter (producter_firstname, producter_secondname, producter_phone, producter_password)
                VALUES (?, ?, ?, ?)
            `;
            db.query(query, [producterFirstName, producterSecondName, producterPhone, hashedPassword], (err, result) => {
                if (err) return callback(err);
                callback(null, result);
            });
        });
    }
    

    static findByPhone(prodtData, callback) {

        const { producterPhone ,producterPassword } = prodtData;
        const query = `SELECT * FROM producter WHERE producter_phone = ?`;
        db.query(query, [producterPhone], (err, results) => {
            if(err){
                callback(err);
            }else if(results.length>0){
                const producter = results[0];
                bcrypt.compare(producterPassword, producter.producter_password, (err, result)=>{

                    if(result){
                        callback(null, producter);
                    }else{
                        callback(null, null);
                    }
                });
            }else{
                callback(null, null);
            }
        })
    }


}

module.exports = Producteur;