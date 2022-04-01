const express = require('express');

 module.exports = function () {
     var router = express.Router();
     var users = require('./users')();
     var foodadmin = require('./foodadmin')();
     router.use('/users',users);
     router.use('/foodadmin',foodadmin);
     router.get('/',function(req, res) {
         res.render('admin/index.ejs')
     })
     return router;
 };