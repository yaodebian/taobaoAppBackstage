const express = require('express');
const body_parser = require('body-parser');
const db = require('../db/db');

module.exports = function () {
  let router = express.Router();
  
  router.use(body_parser.urlencoded({
    extended: false,
    limit: 2*1024*1024
  }));

  router.use(body_parser.json());

  router.post('/addIntoCart', function(req, res){
    let goodsId = req.body.goodsId;
    let userId = req.body.userId;
    db.query(`insert into liqi_taobao_cart (goodsId, userId, cartCount) values ('${goodsId}', '${userId}')`, (err, data) => {
      if (err) {
        console.log(err);
        res.status(500).send("database query failure").end();
      }
      else {
        let dataItem = data[0];
        console.log(dataItem);
        res.send(dataItem).end();
      }
    })
  })

  return router;
}