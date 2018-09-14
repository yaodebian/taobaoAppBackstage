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

  router.post('/getGoods', function(req, res){
    let searchVal = req.body.searchVal;
    // let searchKeys = searchVal.split('');
    let blurStr = `like '%${searchVal}%'`;
    for(let i = 0; i < searchVal.length - 1; i++) {
      let preStr = searchVal.substring(0, i + 1);
      let bhiStr = searchVal.substring(i + 1);
      blurStr += ` or goodsName like '%${preStr}%' or goodsName like '%${bhiStr}%'`;
    }
    db.query(`select * from liqi_taobao_goods where goodsName ${blurStr} limit 10`, (err, data) => {
      if (err) {
        console.log(err);
        res.status(500).send("database query failure").end();
      }
      else {
        res.send(data).end();
      }
    })
  })

  return router;
}