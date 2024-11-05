var express = require('express');
//var bodyParser = require('body-parser')
var app = express()
var entrepotProcheRoutes=require('./entrepotProcheRoutes');
const bodyParser = require('body-parser');
//const cors = require('core-js');
const cors = require('cors');


app.use(cors());


// Middleware pour parser les données JSON
app.use(bodyParser.json());

// Middleware pour parser les données urlencoded
app.use(express.urlencoded({ extended: false }));

// Setup routes
app.use('/tera/entrepot', entrepotProcheRoutes);


//Start Server
// Écoute sur une adresse IP spécifique
const host = '0.0.0.0'; 
var port =3002;
app.listen(port, host, ()=>{
    console.log(`Server is running on port ${port}`)
});
