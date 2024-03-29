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
var saveMessage = require('./routes/savemessage')
var becomeadmin = require('./routes/becomeadmin')
var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({
  extended: false
}));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static('addGoodsImg'))

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/customer', customerRouter);
app.use('/menu', menuRouter);
app.use('/order', orderRouter);
app.use('/fontadmin', adminRouter);
app.use('/foodadmin', foodadminRouter);
app.use('/savemessage', saveMessage);
app.use('/becomeadmin', becomeadmin);
//跳转后台
var adminIndex = require('./router/admin/index')();
app.use('/admin', adminIndex);
//静态文件的请求
app.use(express.static('./static/'));
// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});
// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;