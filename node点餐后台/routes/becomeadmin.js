var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var dbConfig = require('../db/dbConfig')

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

/* GET home page. */
router.post('/', function(req, res) {
    let _res = res
    let params = req.body
    let adminList = JSON.parse(params.adminList)
    let CUSID = adminList.CUSID, adminName = adminList.adminName, adminPasswd = adminList.adminPasswd
    let data = {}
    pool.getConnection(function(err, connection) {
        connection.query(`UPDATE syscus SET CUSID='${CUSID}' where NICKNAME='${adminName}' and PASSWORD='${adminPasswd}'`,function(err,resp){
            if(resp.changedRows==1){
                data.resp = {
                    code: 200,
                    msg: '密码正确，绑定成功'
                  }
            }else if(resp.changedRows==0){
                data.resp = {
                    code:-1,
                    msg:'密码或者账号错误，绑定失败'
                  }
            }
            responseJSON(_res,data)
            connection.release()
        })
    })
})
module.exports = router;