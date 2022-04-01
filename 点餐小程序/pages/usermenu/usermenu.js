// client/pages/pay/pay.js
var app = getApp()
Page({

  /**
   * 页面的初始数据
   */
  data: {
    myfoodsList: [],
    sumprice: 0,
    serveraddr: app.globalData.serveraddr,
    show: false,
    position: 'bottom',
    idList: [],
    idListData: {},
    name: '',
    iphone: '',
    bindId: '',
    sendMessage: {},
    idListShow: false,
    isSave: false,
    editText: '保存'
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (e) {
    var th = this
    this.setData({
      myfoodsList: JSON.parse(e.foodslist),
    }),
    wx.request({
      url: app.globalData.serveraddr + '/savemessage/getsavemessage',
      data: {
        CUSID: app.globalData.cusid
      },
      success: res => {
        th.setData({
          name: res.data.name,
          iphone: res.data.iphone,
          bindId: res.data.bindId
        })
      }
    })
    this.saveOrBecome()
  },
  // 保存还是修改
  saveOrBecome:function(){
    console.log('00000000')
    let name = this.data.sendMessage.name ? true : false
    let iphone = this.data.sendMessage.iphone ? true : false
    let bindId = this.data.sendMessage.bindId ? true : false
    if (name == false || iphone == false || bindId == false) {
      this.setData({
        isSave: true,
        editText: '保存'
      })
    }else{
      this.setData({
        isSave: false,
        editText: '修改'
      })
    }
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    var sum = 0;
    for (var i = 0; i < this.data.myfoodsList.length; i++) {
      sum = sum + this.data.myfoodsList[i].gcount * this.data.myfoodsList[i].gprice;
    }
    this.setData({
      sumprice: sum,
    })
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
   
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  },
  sendId: function (e) {
    wx.request({
      url: app.globalData.serveraddr + '/savemessage/getsavemessage',
      data: {
        CUSID: app.globalData.cusid
      },
      success: res => {
        this.setData({
          name: res.data.name,
          iphone: res.data.iphone,
          bindId: res.data.bindId
        })
      }
    })
    this.setData({
      show: true
    })
  },
  exit() {
    this.setData({
      show: false
    })
    console.log(this.data.show)
    // wx.navigateBack()
  },
  bindName: function (e) {
    this.setData({
      name: e.detail.value
    })
  },
  bindIphone: function (e) {
    this.setData({
      iphone: e.detail.value
    })
  },
  bindId: function (e) {
    this.setData({
      bindId: e.detail.value
    })
  },
  // 保存收件人信息
  save: function () {
    let data = {}
    data.name = this.data.name
    data.iphone = this.data.iphone
    data.bindId = this.data.bindId
    data.cusid = app.globalData.cusid
    this.setData({
      sendMessage: data
    })
    let name = this.data.sendMessage.name ? true : false
    let iphone = this.data.sendMessage.iphone ? true : false
    let bindId = this.data.sendMessage.bindId ? true : false
    if (name == false || iphone == false || bindId == false) {
      this.setData({
        show: true,
        isSave: false,
        editText: '保存'
      })
    } else {
      this.saveMessage()
      this.setData({
        show: false,
        isSave: true,
        editText: '修改'
      })
    }
  },
  // 收件人信息保存数据库
  saveMessage: function () {
    let sendMessageJSON = JSON.stringify(this.data.sendMessage)
    wx.request({
      url: app.globalData.serveraddr + '/savemessage',
      data: {
        sendMessageJSON: sendMessageJSON
      },
      method: 'POST',
      header: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
      success: res => {
        console.log(res)
      }
    })
  },
  goinfo: function (e) {
    var list = this.data.myfoodsList;
    for (var i = 0; i < list.length; i++) {
      if (list[i].gid == e.currentTarget.dataset.gid) {
        wx.navigateTo({
          url: '../info/info?foodinfo=' + JSON.stringify(list[i])
        })
      }
    }
  },
  // 结账
  gopay: function () {
    let name = this.data.sendMessage.name ? true : false
    let iphone = this.data.sendMessage.iphone ? true : false
    let bindId = this.data.sendMessage.bindId ? true : false
    if (name == false || iphone == false || bindId == false) {
      this.setData({
        show: true
      })
    } else {
      wx.redirectTo({
        url: '../pay/pay?sumprice=' + this.data.sumprice + '&foodlist=' + JSON.stringify(this.data.myfoodsList),
      })
    }
  }
})