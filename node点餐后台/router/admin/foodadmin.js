var express = require('express');
var router = express.Router()
var dbConfig = require('../../db/dbConfig')
var orderSql = require('../../db/orderSql')
var customerSql = require('../../db/customerSql')
var mysql = require('mysql')
var pool  =mysql.createPool(dbConfig.mysql)

module.exports = function () {
    // 获取未完成（正在处理）订单id
    router.get('/',function (req, res){
        pool.getConnection(function (err, connection){
           var cusOrderArr = []
           var data = {}
           var _res = res
           connection.query(orderSql.queryAllCusOrder,function (err, res) {
               if(res){
                   for(let i = 0; i < res.length; i++){
                       var cusOrder = {}
                       cusOrder.oderid = res[i].ORDERID
                       cusOrder.cusid = res[i].CUSID
                       cusOrder.orderTotlePrice = res[i].ORDERTOTLEPRICE
                       cusOrderArr.push(cusOrder)
                   }
                   data.cusOrderArr = cusOrderArr
                   console.log(data)
                   _res .render('admin/foodadmin.ejs')
               }
           })
        })
    })
    // router.get('/',function(req, res) {
    //     res.render('admin/foodadmin.ejs')
    // })
    return router;
};