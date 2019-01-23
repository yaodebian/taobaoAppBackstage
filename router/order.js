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

  // 获取订单列表
  router.get('/list', function (req, res) {
    let obj = url.parse(req.url, true).query
    let userId = obj.userId
    let status = obj.status
    let str = status != 0 ? `and status=${status}` : ''
    db.query(`select orderId, addressId, totalAmount, payPrice, getPrice, status, isFreight from liqi_taobao_order where userId=${userId} ${str}`, (err, data) => {
      if (err) {
        console.log(err)
        res.status(500).send("database query failure").end()
        return
      }
      if (data.length === 0) {
        res.send([]).end()
        return
      }
      let orderCount = data.length
      let resData = []
      let count = 0
      for (let item of data) {
        let temp = {}
        temp.orderId = item.orderId
        temp.addressId = item.addressId
        temp.totalAmount = item.totalAmount
        temp.payPrice = item.payPrice
        temp.getPrice = item.getPrice
        temp.status = item.status
        temp.isFreight = item.isFreight
        temp.goods = []
        temp.goodsCount = []
        db.query(`select s.storeName, s.sellerImg, s.freightPrice, g.goodsId, g.sellerId, g.goodsName, g.goodsPrice, g.tags, g.column, g.img, g.discount, g.customers, g.location, og.count from liqi_taobao_goods g join liqi_taobao_order o join liqi_taobao_ordergood og join liqi_taobao_seller s on o.orderId=${item.orderId} and o.orderId=og.orderId and g.goodsId=og.goodsId and g.sellerId=s.sellerId`, (err, data) => {
          if (err) {
            console.log(err)
            res.status(500).send("database query failure").end()
            return
          }
          for (let dataItem of data) {
            if (temp.sellerName === undefined) {
              temp.sellerName = dataItem.storeName
              temp.sellerImg = dataItem.sellerImg
              temp.freightPrice = dataItem.freightPrice
            }
            let goodItem = {}
            goodItem.goodsId = dataItem.goodsId
            goodItem.sellerId = dataItem.sellerId
            goodItem.goodsName = dataItem.goodsName
            goodItem.goodsPrice = dataItem.goodsPrice
            goodItem.tags = dataItem.tags
            goodItem.column = dataItem.column
            goodItem.img = dataItem.img
            goodItem.discount = dataItem.discount
            goodItem.customers = dataItem.customers
            goodItem.location = dataItem.location
            temp.goods.push(goodItem)
            temp.goodsCount.push(dataItem.count)
          }
          resData.push(temp)
          count++
          if (count === orderCount) {
            res.send(resData).end()
          }
        })
      }
    })
  })


  // 保存订单
  router.post('/save', function (req, res) {
    let dataObj = req.body.data
    let count = 0

    function delCarts(goods, userId, res) {
      let count = 0
      for (let item of goods) {
        db.query(`delete from liqi_taobao_cart where userId=${userId} and goodsId=${item}`, (err, data) => {
          if (err) {
            console.log(err)
            res.status(500).send("database query failure").end()
            return
          }
          count++
          if (count === goods.length) res.send(true).end()
        })
      }
    }

    for (let item of dataObj.orders) {
      db.query(`insert into liqi_taobao_order (userId, addressId, totalAmount, payPrice, getPrice, msgtxt, isFreight) values (${dataObj.userId}, ${dataObj.addressId}, '${item.totalAmount}', '${item.payPrice}', '${item.getPrice}', '${item.msgtxt}', ${item.isFreight})`, (err, data) => {
        if (err) {
          console.log(err)
          res.status(500).send("database query failure").end()
          return
        }
        let orderId = data.insertId
        let num = 0
        for (let i in item.goods) {
          db.query(`insert into liqi_taobao_orderGood (orderId, goodsId, count) values (${orderId}, ${item.goods[i]}, ${item.goodsCount[i]})`, (err, data) => {
            if (err) {
              console.log(err)
              res.status(500).send("database query failure").end()
              return
            }
            num++
            if (num === item.goods.length) {
              count++
              if (count === dataObj.orders.length) {
                let temp = []
                for (let item of dataObj.orders) {
                  temp = temp.concat(item.goods)
                }
                delCarts(temp, dataObj.userId, res)
              }
            }
          })
        }
      })
    }
  })

  // 删除订单
  router.get('/del', function (req, res) {
    let obj = url.parse(req.url, true).query
    let orderId = obj.orderId
    db.query(`delete from liqi_taobao_ordergood where orderId=${orderId}`, (err, data) => {
      if (err) {
        console.log(err)
        res.status(500).send("database query failure").end()
        return
      }
      db.query(`delete from liqi_taobao_order where orderId=${orderId}`, (err, data) => {
        if (err) {
          console.log(err)
          res.status(500).send("database query failure").end()
          return
        }
        res.send(true).end()
      })
    })
  })

  // 订单支付
  router.post('/pay', function (req, res) {
    let orderId = req.body.orderId
    db.query(`update liqi_taobao_order set status=2 where orderId=${orderId}`, (err, data) => {
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