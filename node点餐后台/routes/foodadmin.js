/*
    菜品添加修改
*/
var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var menuSql = require("../db/menuSql")
var dbConfig = require('../db/dbConfig')
var uuid = require('node-uuid')
var formidable = require("formidable")
var path = require("path")
var fs = require("fs")


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

router.get('/', function (req, res, next) {
    pool.getConnection(function (err, connection) {
        var datalist = [];
        var data = {};
        var goodslist = [];
        var typelist;
        var foodslist;
        connection.query(menuSql.queryGoodsTypeAll, function (err, e) {
            if (e) {
                typelist = e;
            }
        })
        connection.query(menuSql.queryGoodsAll, function (err, e) {
            if (e) {
                foodslist = e;
            }
            for (var i = 0; i < typelist.length; i++) {
                data.gt = typelist[i];
                // console.log(data.gt)
                for (var j = 0; j < foodslist.length; j++) {
                    if (typelist[i].GTID == foodslist[j].GTID) {
                        goodslist.push(foodslist[j]);
                    }
                }
                data.goodslist = goodslist;
                goodslist = [];
                // console.log(data.goodslist)
                datalist.push(data);
                data = {};
            }
            //    console.log(datalist[0].goodslist);
            //   发送数据
            responseJSON(res, datalist)
        })

        //   断开数据库
        connection.release()
    })
});
// 下架删除菜品
router.get('/uninstall', function (req, res, next) {
    var params = req.query || req.params
    var data = {}
    var _res = res
    pool.getConnection(function (err, connection) {
        connection.query(`DELETE FROM goods where GID='${params.foodinfo}'`, function (err, e) {
            if (e) {
                data.result = {
                    code: 200,
                    msg: '下架成功'
                }
            } else {
                data.result = {
                    code: -1,
                    msg: '下架失败'
                }
            }
            responseJSON(_res, data)
            //   断开数据库
            connection.release()
        })
    })
});
// 修改菜品
router.get('/alert', function (req, res, next) {
    var params = req.query || req.params
    var foodinfo = JSON.parse(params.foodinfo);
    var data = {}
    var _res = res
    pool.getConnection(function (err, connection) {
        var modSql = `UPDATE goods SET GTID='${foodinfo.GTID}',GNAME='${foodinfo.GNAME}',GPRICE=${foodinfo.GPRICE},GCONTENT='${foodinfo.GCONTENT}',GCOUNT=${foodinfo.GCOUNT},GINFO='${foodinfo.GINFO}' WHERE GID='${foodinfo.GID}'`
        console.log(modSql)
        connection.query(modSql, function (err, result) {
            if (result) {
                data.result = {
                    code: 200,
                    msg: '修改成功'
                }
            } else {
                data.result = {
                    code: -1,
                    msg: '修改失败'
                }
            }
            responseJSON(_res, data)
        });
        connection.release()
    })
});

router.get('/getGoodType', function (req, res, next) {
    var data = {}
    var _res = res
    pool.getConnection(function (err, connection) {
        connection.query(menuSql.queryGoodsTypeAll, function (err, res) {
            if (res) {
                data.goodstypes = res
            }
            responseJSON(_res, data)
        });
        connection.release()
    })
});

router.get('/addGoodType', function (req, res, next) {
    var params = req.query || req.params
    var gtname = params.newtypename
    var gtid = params.gtid
    var data = {}
    var _res = res
    pool.getConnection(function (err, connection) {
        connection.query(menuSql.insertGoodsType, [gtid, gtname, 1], function (err, result) {
            if (result) {
                data.result = {
                    code: 200,
                    msg: '添加成功'
                }
            } else {
                data.result = {
                    code: -1,
                    msg: '添加失败'
                }
            }
            responseJSON(_res, data)
        });
        connection.release()
    })
});
// 以下添加菜品信息
var imgGid = ''
let arrImgs = {
    img:'',//主图
    imgList:[] // 轮播图
}
router.get('/addGoods', function (req, res, next) {
    var params = req.query || req.params
    var foodinfo = JSON.parse(params.foodinfo);
    var data = {}
    var _res = res
    var gid = uuid.v4()
    imgGid = gid
    arrImgs.img = 'food1.png'
    let imgJSON = JSON.stringify(arrImgs)
    arrImgs.img = ''
    pool.getConnection(function (err, connection) {
        connection.query(menuSql.insertGoods, [gid, foodinfo.gtid, foodinfo.gname, 1, parseInt(foodinfo.gprice), foodinfo.gcontent, imgJSON, 5, 0, foodinfo.ginfo], function (err, result) {
            if (result) {
                data.result = {
                    code: 200,
                    msg: '添加成功'
                }
            } else {
                data.result = {
                    code: -1,
                    msg: '添加失败'
                }
            }
            responseJSON(_res, data)
        });
        connection.release()
    })
});
// 菜品图片上传

router.post('/addGoodsImg', function (req, res, next) {
    var params = req.query || req.params
    var imgName = ''
    var form = new formidable.IncomingForm() //既处理表单，又处理文件上传  

    //设置文件上传文件夹/路径，__dirname是一个常量，为当前路径
    let uploadDir = path.join(__dirname, "../public/images")
    form.uploadDir = uploadDir; //本地文件夹目录路径

    form.parse(req, (err, fields, files) => {
        let oldPath = files.fileImg.path; //这里的路径是图片的本地路径 
        //图片传过来的名字
        let newPath = path.join(path.dirname(oldPath), files.fileImg.name);
        imgName = files.fileImg.name
        console.log(arrImgs)
        if(!arrImgs.img){
            arrImgs.img = imgName
        }else{
            arrImgs.imgList.push(imgName)
        }
        console.log(JSON.stringify(arrImgs))
        //这里我传回一个下载此图片的Url
        var downUrl = "http://localhost:3000/images/" + files.fileImg.name; //这里是想传回图片的链接
        fs.rename(oldPath, newPath, () => { //fs.rename重命名图片名称
            console.log('图片成功')
        })
        pool.getConnection(function (err, connection) {
            var modSql = `UPDATE goods SET GIMG='${JSON.stringify(arrImgs)}' WHERE GID='${imgGid}'`
            connection.query(modSql, function (err, result) {
                if (result) {
                    console.log('图片名字修改成功')
                    imgName = ''
                }
            });
            connection.release()
        })
    })

});

module.exports = router;