var express = require('express');
var router = express.Router()
var dbConfig = require('../../db/dbConfig')
var orderSql = require('../../db/orderSql')
var customerSql = require('../../db/customerSql')
var mysql = require('mysql')
var pool  =mysql.createPool(dbConfig.mysql)
const deFault = function(res){
    pool.getConnection(function (err, connection){
        var cusOrderArr = []
        var data = {}
        var _res = res
        connection.query(orderSql.queryAllCusOrder,function (err, res) {
            if(res){
                for(let i = 0; i < res.length; i++){
                    var cusOrder = {}
                    cusOrder.oderid = res[i].ORDERID
                 //    cusOrder.cusid = res[i].CUSID
                 //    cusOrder.orderTotlePrice = res[i].ORDERTOTLEPRICE
                    cusOrder.FOODJSON = JSON.parse(res[i].FOODJSON)
                    cusOrder.NAME = res[i].NAME
                    cusOrder.IPHONE = res[i].IPHONE
                    cusOrder.BINDID = res[i].BINDID
                    cusOrderArr.push(cusOrder)
                }
                data.cusOrderArr = cusOrderArr
                _res .render('admin/foodadmin.ejs',{
                 foodData: data.cusOrderArr
             })
             connection.release()
            }
        })
     })
}
const good = function(req,res){
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
                connection.release()
                _res.redirect('/admin/foodadmin');
              })
            }
          })
        }
      })
    })
}
module.exports = function () {
    // 获取未完成（正在处理）订单id
    router.get('/',function (req, res, next){
        switch(req.query.action){
            case 'good':
                good(req,res)
                break;
            default:
                deFault(res)
        }
    });
    // router.get('/',function(req, res) {
    //     res.render('admin/foodadmin.ejs')
    // })
    return router;
};