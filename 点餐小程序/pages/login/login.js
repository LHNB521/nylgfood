// client/pages/login.js
const app = getApp()

Page({
  data: {
    userInfo: {},
    hasUserInfo: false,
    canIUse: wx.canIUse('button.open-type.getUserInfo'),
    isAdmin: false
  },

  onLoad: function () {
    var t = this
    wx.onAppRoute(res => {
      var a = getApp(), b = a.globalData.targetPageEventChannel
      if (b && res.path != t.route) {
        a.globalData.targetPageEventChannel = false
      }
    })
    getApp().watch((value) => {
      this.setData({
        isAdmin: value
      })
    })
    var that = this
    app.getOpenId().then(function (res) {
      if (app.globalData.userInfo) {
        that.setData({
          userInfo: res.userInfo,
          hasUserInfo: true
        })
      } else if (this.data.canIUse) {
        // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回
        // 所以此处加入 callback 以防止这种情况
        app.userInfoReadyCallback = res => {
          that.setData({
            userInfo: res.userInfo,
            hasUserInfo: true
          })
        }
      } else {
        // 在没有 open-type=getUserInfo 版本的兼容处理
        wx.getUserInfo({
          success: res => {
            app.globalData.userInfo = res.userInfo
            that.setData({
              userInfo: res.userInfo,
              hasUserInfo: true
            })
          }
        })
      }
    })
  },
  // 订单记录按钮
  orderPage:function(e) {
    wx.navigateTo({
      url: '../order/order'
    })
  },
  // 立即点餐按钮
  joinPage: function (e) {
    if (app.globalData.isLogin) {
      //成功，后续逻辑：判断用户是否有正在处理的订单，如果有，那么跳转到订单页面；如果没有跳转到菜单页面。
      if (app.globalData.isHaveOrder) {
        console.log(app.globalData.isHaveOrder)
        wx.navigateTo({
          url: '../order/order',
          events: {
            // 为指定事件添加一个监听器，获取被打开页面传送到当前页面的数据
            backFromTargetPage: function (backData) {
              if (backData.from == 'page2') {
                // 监听到 page2 返回
                console.log('好啦，可以在这里写你的逻辑了', backData)
                app.getOpenId()
              }
            }
          }
        })
      } else {
        wx.navigateTo({
          url: '../menu/menu',
          events: {
            // 为指定事件添加一个监听器，获取被打开页面传送到当前页面的数据
            backFromTargetPage: function (backData) {
              if (backData.from == 'page1') {
                // 监听到 page2 返回
                console.log('好啦，可以在这里写你的逻辑了', backData)
                app.getOpenId()
              }
            }
          }
        })
      }
    }
  },
  openadmin: function () {
    wx.navigateTo({
      url: '../severmenu/severmenu'
    })
  },
})