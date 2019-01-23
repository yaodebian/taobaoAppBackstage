const express = require('express')
const body_parser = require('body-parser')
const db = require('../db/db')
const cookieParser = require('cookie-parser')
const session = require('express-session');

module.exports = function () {
  let router = express.Router()

  router.use(body_parser.urlencoded({
    extended: false, //扩展模式
    limit: 2 * 1024 * 1024 //限制-2M
  }))

  router.use(body_parser.json())

  router.use(cookieParser())

  //session配置
  router.use(session({
    secret: 'yaodebiantaobao',
    cookie: {
      maxAge: 60 * 60 * 1000, // 1小时
      httpOnly: false
    }
  }))

  // 注册
  router.post('/reg', function (req, res) {
    let phone = req.body.phone
    db.query(`insert into liqi_taobao_user (phone) values('${phone}')`, (err, data) => {
      if (err) {
        if (err.sqlState == '23000') {
          res.send({
            repeatCode: true
          }).end
          return
        }
        console.log(err)
        res.status(500).send("database query failure").end()
      } else {
        let userId = data.insertId
        req.session.phone = phone
        // res.cookie('phone', phone, {
        //   maxAge: 1000 * 60 * 60
        // })
        res.send({
          userId
        }).end()
      }
    })

  })

  // 登录
  router.post('/login', function (req, res) {
    let flag = req.body.flag
    if (req.session.phone || flag) {
      let phone = req.session.phone || req.body.phone
      db.query(`select * from liqi_taobao_user where phone = '${phone}'`, (err, data) => {
        if (err) {
          res.status(500).send("database query failure").end()
        } else {
          req.session.phone = data[0].phone
          let dataItem = data[0]
          res.send(dataItem).end()
        }
      })
    } else {
      let count = req.body.count
      let password = req.body.password
      db.query(`select * from liqi_taobao_user where username = '${count}'`, (err, data) => {
        if (err) {
          res.status(500).send("database query failure").end()
        } else {
          if (data.length == 0 || data[0].password != password) {
            res.send(false).end()
          } else {
            req.session.phone = data[0].phone
            let dataItem = data[0]
            res.send(dataItem).end()
          }
        }
      })
    }
  })
  
  // 保存昵称
  router.post('/saveNick', function (req, res) {
    let userId = req.body.userId
    let nick = req.body.nick
    db.query(`update liqi_taobao_user set nick = '${nick}' where userId = '${userId}'`, (err, data) => {
      if (err) {
        res.status(500).send("database query failure").end()
      } else {
        res.send(true).end()
      }
    })

  })

  // 保存用户名
  router.post('/saveUsername', function (req, res) {
    let userId = req.body.userId
    let username = req.body.username
    let password = req.body.password
    db.query(`select * from liqi_taobao_user where userId != '${userId}' and username = '${username}'`, (err, data) => {
      if (err) {
        console.log(err)
        res.status(500).send("database query failure").end()
      } else {
        if (data.length == 0) {
          db.query(`update liqi_taobao_user set username = '${username}', password = '${password}' where userId = '${userId}'`, (err, data) => {
            if (err) {
              console.log(err)
              res.status(500).send("database query failure").end()
            } else {
              res.send(true).end()
            }
          })
        } else {
          res.send(false).end()
        }
      }
    })

  })

  return router
}