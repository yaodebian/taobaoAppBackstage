const express = require('express')
const express_static = require('express-static')

var server = express()

server.all('*', function (req, res, next) {
    res.header('Access-Control-Allow-Origin', 'http://localhost:8080')
    res.header('Access-Control-Allow-Headers', 'Content-Type,Content-Length, Authorization, Accept,X-Requested-With')
    res.header('Access-Control-Allow-Methods', 'PUT,POST,GET,DELETE,OPTIONS')
    //这段仅仅为了方便返回json而已
    res.header('Content-Type', 'application/json;charset=utf-8');
    res.header('Access-Control-Allow-Credentials', 'true')
    if (req.method == 'OPTIONS') {
        //让options请求快速返回
        res.sendStatus(200)
    } else {
        next()
    }
})

server.listen(8081)

//router
server.use('/user/', require('./router/user.js')())
server.use('/goods/', require('./router/goods.js')())
server.use('/checkCode/', require('./router/checkCode.js')())
server.use('/search/', require('./router/search.js')())
server.use('/seller/', require('./router/seller.js')())
server.use('/cart/', require('./router/cart.js')())

server.use(express_static('./static')) //其余所有访问默认丢给static目录