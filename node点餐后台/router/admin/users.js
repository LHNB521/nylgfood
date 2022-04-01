var express = require('express');
var router = express.Router()
var mysql = require('mysql');
var fs = require('fs');
var dbConfig = require('../../db/dbConfig');
var syscusSql = require("../../db/syscusSql")
var pool = mysql.createPool(dbConfig.mysql)
module.exports = function () {
    router.get('/', function (req, res, next) {
        switch (req.query.action) {
            case 'del':
                pool.getConnection(function (err, connection) {
                    var cusid = req.query.id
                    connection.query(`DELETE FROM syscus where CUSID='${cusid}'`, function (err, e) {
                        if (err) {
                            console.log('[DELETE ERROR] - ', err.message);
                            return;
                        }
                    });
                    connection.query(syscusSql.queryAll, function (err, e) {
                        if (e) {
                            res.render('admin/users.ejs', {
                                usersData: e
                            });
                        }
                    })
                    connection.release()
                })
                break;
            default:
                pool.getConnection(function (err, connection) {
                    connection.query(syscusSql.queryAll, function (err, e) {
                        if (e) {
                            res.render('admin/users.ejs', {
                                usersData: e
                            });
                        }
                    })
                    connection.release()
                });
        }
    });
    router.post('/', function(req, res){
        var reqData = []
        reqData.push(req.body.cusid);
        reqData.push('管理员:' + req.body.cusid);
        reqData.push('false');
        pool.getConnection(function (err,connection) {
            connection.query(syscusSql.insert,reqData,function (err,e) {
                if(err){
                    console.log('[INSERT ERROR] - ', err.message);
                    return;
                }
            })
            connection.query(syscusSql.queryAll, function (err, e) {
                if (e) {
                    res.render('admin/users.ejs', {
                        usersData: e
                    });
                }
            })
            connection.release()
        })
    })



    return router;
};