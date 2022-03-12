# 基于微信小程序的点餐系统
微信小程序-点餐系统（包含前端，后台及数据库表）


### 技术栈及工具

工具：微信开发者工具 vscode mysql

前端： html + css + js + 小程序api + weui

后台： nodejs + express框架 + mysql数据库


###### 后台运行步骤：

导入mhzqx.sql表数据到数据库中

cd 后台

修改db文件夹目录下的dbConfig.js文件 为自己的数据库配置

重点：修改routes文件夹下customer.js里面的appid和secret为自己小程序号的小程序id和密钥

npm install

npm start

