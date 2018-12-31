const express = require('express')
const body_parser = require('body-parser')
const db = require('../db/db')

function getCheckCode() {
  let selectChar = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
  let code = ''
  for (let i = 0; i < 4; i++) {
    let codeIndex = Math.floor(Math.random() * 62)
    code += selectChar[codeIndex]
  }
  return code
}

module.exports = function () {
  let router = express.Router()

  router.use(body_parser.urlencoded({
    extended: false,
    limit: 2 * 1024 * 1024
  }))

  router.use(body_parser.json())

  // 获取注册验证码
  router.get('/getRegCode', function (req, res) {
    let checkCode = getCheckCode()
    res.send({
      checkCode
    })
  })

  // 获取登录验证码
  router.post('/getLoginCode', function (req, res) {
    let phone = req.body.count
    db.query(`select * from liqi_taobao_user where phone = '${phone}'`, (err, data) => {
      if (err) {
        console.log(err)
        res.status(500).send("database query failure").end()
        return
      }
      if (data.length === 0) {
        res.send(false)
        return
      }
      let checkCode = getCheckCode()
      res.send({
        checkCode
      })
    })
  })

  return router
}