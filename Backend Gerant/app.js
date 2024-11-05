var express = require('express');
var bodyParser = require('body-parser')
var app = express()
var gerantRoute=require('./routes/gerantRoutes');
const cors = require('cors');




/// Middleware pour parser les données JSON
app.use(bodyParser.json());
app.use(express.urlencoded({ extended: false }));
app.use(cors());


// Setup routes
app.use('/tera/gerant', gerantRoute);


//Start Server
// Écoute sur une adresse IP spécifique
const host = '0.0.0.0'; 
var port =3030;
app.listen(port, host, ()=>{
    console.log(`Server is running on port ${port}`)
});
