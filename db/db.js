var mysql = require('mysql')
var db = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'yaodebian',
  database: 'db_practice'
})

module.exports = db