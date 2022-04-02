var express = require('express');
var router = express.Router();
var dbConfig = require('../db/dbConfig')
var mysql = require('mysql');
var savemessageSql = require('../db/savemessageSql')

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
var mycusid = ''

// 保存收获人的信息
router.post('/',function (req,res){
  let _res = res
  let params = req.body
  let sendMessage = JSON.parse(params.sendMessageJSON)
  let CUSID = sendMessage.cusid,NAME=sendMessage.name
  let IPHONE = sendMessage.iphone,BINDID = sendMessage.bindId
  let data = {}
  pool.getConnection(function (err, connection) {
    connection.query(`SELECT * FROM savemessage where CUSID='${CUSID}'`, function (err, resp){
      if(resp[0]){
        mycusid = resp[0].CUSID
        connection.release()
      }else{
        mycusid = ''
        connection.release()
      }
    })
  })
  if(mycusid == CUSID){
    //如果有记录就修改
    pool.getConnection(function (err, connection) {
      connection.query(`UPDATE savemessage SET NAME='${NAME}' ,IPHONE='${IPHONE}'  ,BINDID='${BINDID}' where CUSID='${CUSID}'`, function (err, resp){
        if(resp){
          data.resp = {
            code: 200,
            msg: '收货信息修改成功'
          }
        }else{
          data.resp = {
            code:-1,
            msg:'收货信息修改失败'
          }
        }
        responseJSON(_res,data)
        connection.release()
      })
    })
  }else{
    //如果没有记录就添加
    pool.getConnection((err,connection) => {
      connection.query(savemessageSql.insertSavemessageSql,[CUSID,NAME,IPHONE,BINDID], function (err,result){
        if(result){
          data.result = {
            code: 200,
            msg: '收货信息添加成功'
          }
        }else{
          data.result = {
            code:-1,
            msg:'收货信息添加失败'
          }
        }
        responseJSON(_res,data)
        connection.release()
      })
    })
  }

})
// 获取收货人信息
router.get('/getsavemessage', function (req, res, next) {
  var params = req.query || req.params
  var cusid = params.CUSID
  var _res = res
  if(cusid){
    pool.getConnection(function (err, connection) {
      let getSaveMessage = {}
      connection.query(`SELECT * FROM savemessage where CUSID='${cusid}'`, function (err, resp){
        if(resp[0]){
          getSaveMessage.cusid = resp[0].CUSID
          getSaveMessage.name = resp[0].NAME
          getSaveMessage.iphone = resp[0].IPHONE
          getSaveMessage.bindId = resp[0].BINDID
          responseJSON(_res, getSaveMessage)
          connection.release()
        }else{
          connection.release()
        }
      })
    })
  }
})

module.exports = router;
