// client/pages/login.js
const app = getApp()
Page({
  data: {
    userInfo: {},
    hasUserInfo: false,
    canIUse: wx.canIUse('button.open-type.getUserInfo'),
    isAdmin: false,
    lastTime: '',
    count: 0,
    adminInput: false,
    adminName: '',
    adminPasswd: ''
  },

  onLoad: function () {
    var t = this
    wx.onAppRoute(res => {
      var a = getApp(),
        b = a.globalData.targetPageEventChannel
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
  orderPage: function (e) {
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
  // 连续点击头像
  avatarUrl: function (e) {
    // 获取这次点击时间
    var thisTime = e.timeStamp;
    // 获取上次点击时间 默认为0
    var lastTime = this.data.lastTime;
    var count = this.data.count
    if (lastTime != 0) {
      if (thisTime - this.data.lastTime < 500) {
        count++
        if (count > 5) {
          this.goAdminInput()
          count = 0
        }
      } else {
        count = 0
      }
    }
    // 赋值
    this.setData({
      count: count,
      lastTime: thisTime
    })
  },
  goAdminInput: function () {
    let that = this
    wx.showModal({
      cancelColor: 'cancelColor',
      content: '是否绑定管理员账号，账号仅此绑定一次！',
      success(res) {
        if (res.confirm) {
          that.setData({
            adminInput: true
          })
        } else if (res.cancel) {
          that.setData({
            adminInput: false
          })
        }
      }
    })
  },
  // 取消输入
  cancel: function () {
    let that = this
    that.setData({
      adminInput: false
    })
  },
  bindAdminName: function (e) {
    this.setData({
      adminName: e.detail.value
    })
  },
  bindAdminPasswd: function (e) {
    this.setData({
      adminPasswd: e.detail.value
    })
  },
  // 确定
  adminSend: function () {
    let data = {
      adminName: this.data.adminName,
      adminPasswd: this.data.adminPasswd,
      CUSID: 'qeqweqdsadsaoww'
    }
    let adminJSON = JSON.stringify(data)
    wx.request({
      url: app.globalData.serveraddr + '/becomeadmin',
      data: {
        adminList: adminJSON
      },
      method: 'POST',
      header: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
      success: res => {
        if (res.data.resp.code == 200) {
          wx.showToast({
            title: res.data.resp.msg,
            icon: 'success',
            duration: 2000
          })
          this.setData({
            adminInput: false
          })
        } else {
          wx.showToast({
            title: res.data.resp.msg,
            icon: 'none',
            duration: 2000
          })
        }

        console.log(res)
      }
    })
  }
})