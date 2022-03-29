var express = require('express');
var router = express.Router();

/* 获取主页. */
router.get('/', function(req, res, next) {
  res.render('index', { title: '点餐后台系统' });
});

module.exports = router;
