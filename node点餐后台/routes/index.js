var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var dbConfig = require('../db/dbConfig')
var pool = mysql.createPool(dbConfig.mysql)
// 登录页面
// 登录请求
router.post('/', function (req, res, next) {
  let username = req.body.username
  let userpassword = req.body.userpassword
  pool.getConnection(function (err, connection) {
    connection.query(`SELECT * FROM syscus WHERE NICKNAME = '${username}'`, function (err, e) {
      if (err) {
        res.render('index')
        return
      };
      if (e.length !== 1) {
        res.render('index')
        return
      }
      const result = userpassword == e[0].PASSWORD ? true : false
      if (result) {
        res.render('admin/index.ejs');
      } else {
        res.render('index');
      }
    })
    connection.release()
  })
});
router.get('/', function (req, res, next) {
  res.render('index');
});

module.exports = router;