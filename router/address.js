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

  // 获取用户地址列表
  router.get('/getAddressList', function (req, res) {
    let obj = url.parse(req.url, true).query
    let userId = obj.userId
    db.query(`select * from liqi_taobao_address where userId='${userId}'`, (err, data) => {
      if (err) {
        console.log(err)
        res.status(500).send("database query failure").end()
        return
      }
      res.send(data).end()
    })
  })

  // 获取某个具体的地址
  router.get('/getAddressItem', function (req, res) {
    let obj = url.parse(req.url, true).query
    let addressId = obj.addressId
    db.query(`select * from liqi_taobao_address where addressId='${addressId}'`, (err, data) => {
      if (err) {
        console.log(err)
        res.status(500).send("database query failure").end()
        return
      }
      res.send(data[0]).end()
    })
  })

  // 获取用户默认地址项
  router.get('/default', function (req, res) {
    let obj = url.parse(req.url, true).query
    let userId = obj.userId
    db.query(`select * from liqi_taobao_address where userId='${userId}'`, (err, data) => {
      if (err) {
        console.log(err)
        res.status(500).send("database query failure").end()
        return
      }
      for (let item of data) {
        if(item.isDefault === 1) {
          res.send(item).end()
          return
        }
      }
      res.send(data[0]).end()
    })
  })

  // 保存地址项
  router.post('/saveAddress', function (req, res) {
    let flag = req.body.flag
    let data = req.body.data
    // 如果本次插入或更新的数据为默认地址
    if (data.isDefault) {
      new Promise((resolve, reject) => {
          // 获取默认地址addressId
          db.query(`select * from liqi_taobao_address where userId='${data.userId}'`, (err, data) => {
            if (err) {
              console.log(err)
              res.status(500).send("database query failure").end()
              return
            }
            let addressId = ''
            for (let item of data) {
              if (!!item.isDefault) {
                addressId = item.addressId
                break
              }
            }
            if (addressId !== '') {
              resolve(addressId)
              return
            }
            reject(addressId)
          })
        })
        // 如果存在addressId
        .then(function (addressId) {
          // 插入操作
          if (flag) {
            // 1.插入数据
            new Promise((resolve, reject) => {
                db.query(`insert into liqi_taobao_address (userId, receiver, tel, area, detailAdd, tagVal, isDefault) values (${data.userId}, '${data.receiver}', '${data.tel}', '${data.area}', '${data.detailAdd}', '${data.tagVal}', ${data.isDefault})`, (err, data) => {
                  if (err) {
                    console.log(err)
                    res.status(500).send("database query failure").end()
                    return
                  }
                  resolve()
                })
              })
              .then(() => {
                // 2.更新数据
                db.query(`update liqi_taobao_address set isDefault=0 where addressId=${addressId}`, (err, data) => {
                  if (err) {
                    console.log(err)
                    res.status(500).send("database query failure").end()
                    return
                  }
                  res.send(true).end()
                })
              })
              return
          }
          // 将数据更新，这里我们要判断更新的数据是否原来就是默认的地址项
          // 1.不是原来的默认地址项
          if (addressId !== data.addressId) {
            // a.更新数据
            new Promise((resolve, reject) => {
                db.query(`update liqi_taobao_address set tel='${data.tel}', area='${data.area}', detailAdd='${data.detailAdd}', tagVal='${data.tagVal}', isDefault=${data.isDefault} where addressId=${data.addressId}`, (err, data) => {
                  if (err) {
                    console.log(err)
                    res.status(500).send("database query failure").end()
                    return
                  }
                  resolve()
                })
              })
              .then(() => {
                // b.覆写原来的默认地址项
                db.query(`update liqi_taobao_address set isDefault=0 where addressId=${addressId}`, (err, data) => {
                  if (err) {
                    console.log(err)
                    res.status(500).send("database query failure").end()
                    return
                  }
                  res.send(true).end()
                })
              })
              return
          }
          // 2.是原来的地址项，则直接更新
          db.query(`update liqi_taobao_address set tel='${data.tel}', area='${data.area}', detailAdd='${data.detailAdd}', tagVal='${data.tagVal}', isDefault=${data.isDefault} where addressId=${data.addressId} and userId=${data.userId}`, (err, data) => {
            if (err) {
              console.log(err)
              res.status(500).send("database query failure").end()
              return
            }
            res.send(true).end()
          })
        })
        // 原来不存在默认地址项
        .catch(function () {
          if (flag) {
            db.query(`insert into liqi_taobao_address (userId, receiver, tel, area, detailAdd, tagVal, isDefault) values (${data.userId}, '${data.receiver}', '${data.tel}', '${data.area}', '${data.detailAdd}', '${data.tagVal}', ${data.isDefault})`, (err, data) => {
              if (err) {
                console.log(err)
                res.status(500).send("database query failure").end()
                return
              }
              res.send(true).end()
            })
            return
          }
          db.query(`update liqi_taobao_address set tel='${data.tel}', area='${data.area}', detailAdd='${data.detailAdd}', tagVal='${data.tagVal}', isDefault=${data.isDefault} where addressId=${data.addressId}`, (err, data) => {
            if (err) {
              console.log(err)
              res.status(500).send("database query failure").end()
              return
            }
            res.send(true).end()
          })
        })
      return
    }
    // 本次插入或更新不是默认地址
    if (flag) {
      db.query(`insert into liqi_taobao_address (userId, receiver, tel, area, detailAdd, tagVal, isDefault) values (${data.userId}, '${data.receiver}', '${data.tel}', '${data.area}', '${data.detailAdd}', '${data.tagVal}', ${data.isDefault})`, (err, data) => {
        if (err) {
          console.log(err)
          res.status(500).send("database query failure").end()
          return
        }
        res.send(true).end()
      })
      return
    }
    db.query(`update liqi_taobao_address set tel='${data.tel}', area='${data.area}', detailAdd='${data.detailAdd}', tagVal='${data.tagVal}', isDefault=${data.isDefault} where addressId=${data.addressId}`, (err, data) => {
      if (err) {
        console.log(err)
        res.status(500).send("database query failure").end()
        return
      }
      res.send(true).end()
    })
  })

  // 删除地址项
  router.post('/delAddress', function (req, res) {
    let addressId = req.body.addressId
    let userId = req.body.userId
    db.query(`delete from liqi_taobao_address where addressId=${addressId} and userId=${userId}`, (err, data) => {
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