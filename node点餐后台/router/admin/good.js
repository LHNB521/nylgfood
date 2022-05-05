var express = require('express');
var router = express.Router()
var dbConfig = require('../../db/dbConfig')
var menuSql = require('../../db/menuSql')
var mysql = require('mysql')
var pool = mysql.createPool(dbConfig.mysql)
const deFaultGoodsType = function (res) {
    pool.getConnection(function (err, connection) {
        connection.query(menuSql.queryGoodsTypeAll, function (err, res) {
            console.log(res)

        })
    })
}
module.exports = function () {
    router.get('/', function (req, res, next) {
        deFaultGoodsType(res)
        res.render('admin/good.ejs')
    })
    return router;
};