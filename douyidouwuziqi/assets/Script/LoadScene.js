// Learn cc.Class:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/class.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/class.html
// Learn Attribute:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/reference/attributes.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/life-cycle-callbacks.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/life-cycle-callbacks.html

var UiBase = require('UiBase');

cc.Class({
    extends: UiBase,

    properties: {
        btnstart: {
            default: null,
            type: cc.Button
        },
        background: {
            default: null,
            type: cc.Sprite
        }
    },

    // LIFE-CYCLE CALLBACKS:

    onLoad() {
        console.log(" file=LoadScene  func=onLoad");
        this.btnstart.node.on('click', this.onBtnStart, this);
    },
    
    start () {
        console.log(" file=LoadScene  func=start");

        // 判断是否是微信小程序环境
        if (cc.sys.browserType === cc.sys.BROWSER_TYPE_WECHAT_GAME) {
            console.log(" file=LoadScene  func=onBtnStart; 微信小程序环境");
            // that 用于调用本脚本对象函数
            var that = this;
            wx.getUserInfo({
                fail: function(res){
                    console.log(" file=LoadScene  func=onBtnStart  用户授权：拒绝");
                    // iOS 和 Android 对于拒绝授权的回调 errMsg 没有统一，需要做一下兼容处理
                    if (res.errMsg.indexOf('auth deny') > -1 ||     res.errMsg.indexOf('auth denied') > -1 ) {
                        // 处理用户拒绝授权的情况
                    }
                },
                success: function(res) {
                    console.log(" file=LoadScene  func=onBtnStart  用户授权：同意");
                },
            });
        }
        // 其他环境 
        else{
            
        }
    },

    onBtnStart: function(event) {
        console.log(" file=LoadScene  func=onBtnStart; ");
        
        cc.director.loadScene('gamescene');
    },

    update (dt) {

    },
});
