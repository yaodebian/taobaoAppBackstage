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

  router.post('/getSeller', function(req, res){
    console.log(111);
    let sellerId = req.body.sellerId;
    db.query(`select sellerId, sellerImg, storeName, goodsCode, serviceCode, transCode from liqi_taobao_seller where sellerId = '${sellerId}'`, (err, data) => {
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