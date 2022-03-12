// client/pages/login.js
const app = getApp()

Page({
  data: {
    canIUseGetUserProfile: false
  },

  onLoad() {
    if(wx.getUserProfile){
      this.setData({
        canIUseGetUserProfile:true
      })
    }
  },
  getUserProfile: function(){
    wx.getUserProfile({
      desc: '用于完善会员资料', // 声明获取用户个人信息后的用途，后续会展示在弹窗中，请谨慎填写
      success: (res) => {
        app.globalData.userInfo = res.userInfo
        wx.navigateTo({
          url: '../login/login'
        })
      }
    })
  },
  getUserInfo: function (e) {
    if (e.detail.userInfo) {
      app.globalData.userInfo = e.detail.userInfo
      wx.navigateTo({
        url: '../login/login'
      })
    } else {
      wx.showToast({
        title: '登录信息获取失败！',
        icon: "none",
        duration: 1000,
        mask: true
      })
    }
  },
})