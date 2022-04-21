var express = require('express');
var router = express.Router();
// 登录页面
/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

module.exports = router;
