const express = require('express')
const body_parser = require('body-parser')
const db = require('../db/db')
const url = require('url')

module.exports = function () {
  let router = express.Router()

  router.use(body_parser.urlencoded({
    extended: false,
    limit: 2 * 1024 * 1024
  }))

  router.use(body_parser.json())

  // 添加购物车
  router.post('/addIntoCart', function (req, res) {
    let goodsId = req.body.goodsId
    let userId = req.body.userId
    db.query(`select * from liqi_taobao_cart where goodsId='${goodsId}' and userId='${userId}'`, (err, data) => {
      if (err) {
        console.log(err)
        res.status(500).send("database query failure").end()
        return
      }
      if (data.length !== 0) {
        db.query(`update liqi_taobao_cart set cartCount=cartCount+1 where cartId='${data[0].cartId}'`, (err, data) => {
          if (err) {
            console.log(err)
            res.status(500).send("database query failure").end()
            return
          }
          res.send(true).end()
        })
        return
      }
      db.query(`insert into liqi_taobao_cart (goodsId, userId) values ('${goodsId}', '${userId}')`, (err, data) => {
        if (err) {
          console.log(err)
          res.status(500).send("database query failure").end()
          return
        }
        res.send(true).end()
      })
    })
  })

  // 获取购物车列表
  router.get('/getCarts', function (req, res) {
    let obj = url.parse(req.url, true).query
    let userId = obj.userId
    db.query(`select s.sellerId, s.storeName, s.sellerImg, s.freightPrice, c.cartCount, g.goodsId, g.sellerId, g.goodsName, g.goodsPrice, g.tags, g.column, g.img, g.discount, g.customers, g.location from liqi_taobao_cart c join liqi_taobao_goods g join liqi_taobao_seller s on c.userId='${userId}' and c.goodsId=g.goodsId and g.sellerId=s.sellerId`, (err, data) => {
      if (err) {
        console.log(err)
        res.status(500).send("database query failure").end()
        return
      }
      // 获取商品数据
      function getGood(item) {
        let good = {}
        good.goodsId = item.goodsId
        good.sellerId = item.sellerId
        good.goodsName = item.goodsName
        good.goodsPrice = item.goodsPrice
        good.tags = item.tags
        good.column = item.column
        good.img = item.img
        good.discount = item.discount
        good.customers = item.customers
        good.location = item.location
        good.freightPrice = item.freightPrice
        return good
      }
      // 将数据push进result中
      function pushToResult(result, item) {
        let temp = {}
        temp.sellerName = item.storeName
        temp.sellerImg = item.sellerImg
        temp.freightPrice = item.freightPrice
        temp.cartCountNum = [item.cartCount]
        temp.list = [getGood(item)]
        result.push(temp)
      }
      // 将商品项加入到result数组中
      function addToResult(result, item) {
        if (result.length === 0) {
          pushToResult(result, item)
          return 1
        }
        for (let i in result) {
          if (result[i].sellerName === item.storeName) {
            result[i].cartCountNum.push(item.cartCount)
            result[i].list.push(getGood(item))
            return 2
          }
        }
        pushToResult(result, item)
        return 3
      }
      let result = []
      for (let item of data) {
        addToResult(result, item)
      }
      res.send(result).end()
    })
  })

  // 删除购物车项
  router.post('/delCart', function (req, res) {
    let userId = req.body.userId
    let goods = req.body.goods
    let count = 0
    for (let item of goods) {
      db.query(`delete from liqi_taobao_cart where userId='${userId}' and goodsId='${item}'`, (err, data) => {
        if (err) {
          console.log(err)
          res.status(500).send("database query failure").end()
          return
        }
        ((++count) === goods.length) && (res.send(true).end())
      })
    }
  })

  // 更新购物车商品数量
  router.post('/updateCount', function (req, res) {
    let userId = req.body.userId
    let goodsId = req.body.goodsId
    let flag = req.body.flag
    // 购物车数量加一还是减一
    let opStr = flag ? '+' : '-'
    db.query(`update liqi_taobao_cart set cartCount=cartCount${opStr}1 where userId='${userId}' and goodsId='${goodsId}'`, (err, data) => {
      if (err) {
        console.log(err)
        res.status(500).send("database query failure").end()
        return
      }
      res.send(true).end()
    })
  })
  return router
}