const { request } = require('express');

const mysql = require('mysql2');
const db = mysql.createConnection({
    host: 'localhost',
    port: 3306,
    user: 'super',
    password:'super',
    database: 'teradatabase'
});

db.connect((err) => {
    if(err) {
        console.error("Database connection error", err.message);
    }else{
        console.log('Database connection successfully');
    }
});

module.exports = db;