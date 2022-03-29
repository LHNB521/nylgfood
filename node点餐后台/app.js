var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var customerRouter = require('./routes/customer')
var menuRouter = require('./routes/menu')
var orderRouter = require('./routes/order')
var adminRouter = require('./routes/admin')
var foodadminRouter = require('./routes/foodadmin')

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static('addGoodsImg'))

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/customer', customerRouter);
app.use('/menu', menuRouter);
app.use('/order', orderRouter);
app.use('/admin', adminRouter);
app.use('/foodadmin', foodadminRouter);

// 捕获404并转发给错误处理程序
app.use(function(req, res, next) {
  next(createError(404));
});

// 错误处理程序
app.use(function(err, req, res, next) {
  // 设置局部变量，只提供开发中的错误
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
  // 呈现错误页面
  res.status(err.status || 500);
  res.render('error');
});
module.exports = app;
