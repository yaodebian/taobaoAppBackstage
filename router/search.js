const express = require('express')
const body_parser = require('body-parser')
const db = require('../db/db')

module.exports = function () {
  let router = express.Router()

  router.use(body_parser.urlencoded({
    extended: false,
    limit: 2 * 1024 * 1024
  }))

  router.use(body_parser.json())

  // 获取关键字集
  router.post('/getKeywords', function (req, res) {
    let preKey = req.body.preKey
    let blurStr = `like '${preKey}%'`
    db.query(`select * from liqi_taobao_keywords where keyword ${blurStr} limit 10`, (err, data) => {
      if (err) {
        console.log(err)
        res.status(500).send("database query failure").end()
      } else {
        let keywords = []
        for (let item of data) {
          keywords.push(item.keyword)
        }
        res.send(keywords).end()
      }
    })
  })

  return router
}