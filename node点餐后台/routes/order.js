/*
  用户下单
*/ 
var express = require('express');
var router = express.Router();
var dbConfig = require('../db/dbConfig')
var uuid = require('node-uuid')
var orderSql = require('../db/orderSql')
var mysql = require('mysql')

var pool = mysql.createPool(dbConfig.mysql)
var responseJSON = function (res, ret) {
  if (typeof ret === 'undefined') {
    res.json({
      code: '-200',
      msg: '操作失败'
    })
  } else {
    res.json(ret)
  }
}
var insertOrderDetail = function (i, connection, data, orderid, foodlist) {
  connection.query(orderSql.insertOrderDetail, [foodlist[i].gid, orderid, foodlist[i].gname, foodlist[i].gcount, foodlist[i].gprice, foodlist[i].gtime], function (err, result) {
    if (result) {
      data.result = {
        goodscode: 200,
        goodsmsg: '订单商品添加成功'
      }
    } else {
      data.result = {
        goodscode: -1,
        goodsmsg: '订单商品添加失败'
      }
    }
    if (err) {
      console.log(err)
    }
  })
}

var allGoods = []

var queryOrderDetail = function (connection, orderid) {
  var orderDetail = []
  connection.query(orderSql.selectOrderDetail + `'${orderid}'`, function (err, res) {
    if (res) {
      for (let i = 0; i < res.length; i++) {
        orderDetail.push(res[i])
      }
    }
    allGoods.push(orderDetail)
  })
}

// 用户点单-订单添加（支付订单）
router.post('/', function(req, res) {
  pool.getConnection((err, connection) => {
    var params = req.body
    var foodlist = JSON.parse(params.foodlist)
    var sendMessage = foodlist[0]
    var mycusid = params.cusid
    var orderid = uuid.v1()
    var cusorders = {}
    var totlePrice = 0
    var orderTotleTime = 0
    var data = {}
    var _res = res
    var foodjson = []
    for (let i = 1; i < foodlist.length; i++) {
      let foodObj = {}
      foodObj.name = foodlist[i].gname
      foodObj.num = foodlist[i].gcount
      totlePrice += foodlist[i].gprice*foodlist[i].gcount
      orderTotleTime += foodlist[i].gtime*foodlist[i].gcount
      foodjson.push(foodObj)
      insertOrderDetail(i, connection, data, orderid, foodlist)
    }
    cusorders.ORDERID = orderid
    cusorders.CUSID = mycusid
    cusorders.ORDERTIME = orderTotleTime
    cusorders.ORDERSTATE = 1
    cusorders.ORDERTOTLEPRICE = totlePrice
    cusorders.NAME = sendMessage.name
    cusorders.IPHONE = sendMessage.iphone
    cusorders.BINDID = sendMessage.bindId
    cusorders.FOODJSON = JSON.stringify(foodjson)
    connection.query(orderSql.insertCusOrder, [cusorders.ORDERID, cusorders.CUSID, cusorders.ORDERTIME, cusorders.ORDERSTATE, cusorders.ORDERTOTLEPRICE, cusorders.NAME, cusorders.IPHONE, cusorders.BINDID, cusorders.FOODJSON], function (err, result) {
      if (result) {
        data.result = {
          code: 200,
          msg: '订单添加成功'
        }
      } else {
        data.result = {
          code: -1,
          msg: '订单添加失败'
        }
      }
      responseJSON(_res, data)
      connection.release()
    })
  })
});
// 用户查看订单
router.get('/getOrders', function(req, res) {
  pool.getConnection((err, connection) => {
    var params = req.query || req.params
    var cusid = params.cusid
    var data = {}
    var timeTotle = 0
    var order = []
    var overOrder = []
    var _res = res
    connection.query(orderSql.queryAllOverOrder, function (err, res) {
      if (res) {
        for (let i = 0; i < res.length; i++) {
          if (cusid = res[i].CUSID) {
            overOrder.push(res[i])
          }
        }
        data.overOrder = overOrder
      }
    })
    connection.query(orderSql.queryAllCusOrder, function (err, res) {
      if (res) {
        for (let i = 0; i < res.length; i++) {
          timeTotle += res[i].ORDERTIME
          res[i].ORDERTIME = timeTotle
        }
        for (let i = 0; i < res.length; i++) {
          if (cusid = res[i].CUSID) {
            res[i].orderSort = i + 1
            order.push(res[i])
            queryOrderDetail(connection, res[i].ORDERID)
          }
        }
        data.order = order
        setTimeout(() => {
          data.orderDetailAll = allGoods
          allGoods = []
        }, 300)
      }
      setTimeout(() => {
        responseJSON(_res, data)
      }, 300)
      connection.release()
    })
  })
});
// 管理员获取未完成（正在处理）订单id
router.get('/getOrderAdmin', function(req, res) {
  pool.getConnection(function (err, connection) {
    var cusOrderArr = []
    var data = {}
    var _res = res
    connection.query(orderSql.queryAllCusOrder, function (err, res) {
      if (res) {
        for (let i = 0; i < res.length; i++) {
          var cusOrder = {}
          cusOrder.orderid = res[i].ORDERID
          cusOrder.cusid = res[i].CUSID
          cusOrder.orderTotlePrice = res[i].ORDERTOTLEPRICE
          cusOrderArr.push(cusOrder)
          // connection.query(orderSql.selectOrderDetail + `'${res[i].ORDERID}'`, function (params) {
            
          // })
        }
        data.cusOrderArr = cusOrderArr
      }
      responseJSON(_res, data)
    })
  })
});
// 订单取消操作
router.get('/orderAdminCancel', function(req, res) {
  var params = req.query || req.params
  var orderid = params.orderid
  var data = {}
  var _res = res
  pool.getConnection(function (err, connection) {
    connection.query(orderSql.deleteCusOrder + `'${orderid}'`, function (err, results) {
      if (results) {
        data.result = {
          code: 200,
          msg: '订单取消成功'
        }
      }else {
        data.result = {
          code: -1,
          msg: '订单取消错误'
        }
      }
      responseJSON(_res, data)
      connection.release()
    })
  })
});
// 管理点击订单完成操作
router.get('/orderAdminOver', function(req, res) {
  var params = req.query || req.params
  var orderid = params.orderid
  var order = {}
  var data = {}
  var _res = res
  pool.getConnection(function (err, connection) {
    connection.query(orderSql.selectCusOrderOrderId + `'${orderid}'`, function (err, res) {
      if (res) {
        order = res[0]
        connection.query(orderSql.insertOverOrder,[order.ORDERID, order.CUSID, order.ORDERTIME, 3, order.ORDERTOTLEPRICE],function (err, result) {
          if (result) {
            connection.query(orderSql.deleteCusOrder + `'${orderid}'`, function (err, results) {
              if (results) {
                console.log('添加成功')
                data.result = {
                  code: 200,
                  msg: '订单完成'
                }
              }else {
                data.result = {
                  code: -1,
                  msg: '订单完成错误'
                }
              }
              responseJSON(_res, data)
              connection.release()
            })
          }
        })
      }
    })
  })
});


module.exports = router;
