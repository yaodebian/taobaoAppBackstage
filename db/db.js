var mysql = require('mysql');
var db = mysql.createPool({
    host: '10.10.38.193',
    user: 'practice',
    password: '123456',
    database: 'db_practice'
});

module.exports = db;