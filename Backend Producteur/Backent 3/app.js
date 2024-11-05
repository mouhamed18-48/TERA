var express = require('express');
//var bodyParser = require('body-parser')
var app = express()
var produitenstockroute=require('./produitroute');
const cors = require('cors');
const bodyParser = require('body-parser');

app.use(cors());
app.use(bodyParser.json());
// Middleware pour parser les données urlencoded
app.use(express.urlencoded({ extended: false }));

// Setup routes
app.use('/tera/produit', produitenstockroute);


//Start Server
// Écoute sur une adresse IP spécifique
const host = '0.0.0.0'; 
var port =3003;
app.listen(port, host, ()=>{
    console.log(`Server is running on port ${port}`)
});
