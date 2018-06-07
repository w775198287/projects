// Learn cc.Class:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/class.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/class.html
// Learn Attribute:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/reference/attributes.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/life-cycle-callbacks.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/life-cycle-callbacks.html

cc.Class({
    extends: cc.Component,

    properties: {
        // foo: {
        //     // ATTRIBUTES:
        //     default: null,        // The default value will be used only when the component attaching
        //                           // to a node for the first time
        //     type: cc.SpriteFrame, // optional, default is typeof default
        //     serializable: true,   // optional, default is true
        // },
        // bar: {
        //     get () {
        //         return this._bar;
        //     },
        //     set (value) {
        //         this._bar = value;
        //     }
        // },
    },

    // LIFE-CYCLE CALLBACKS:

    onLoad () {
        if (cc.sys.browserType !== cc.sys.BROWSER_TYPE_WECHAT_GAME) {
            return;
        }
        
        // 显示：右上角的转发按钮
        wx.showShareMenu();
        // 隐藏：右上角的转发按钮
        wx.hideShareMenu();

        // 被动触发，点击右上角的后出现转发，再点击转发按钮调用
        wx.onShareAppMessage(function () {
            // 用户点击了“转发”按钮
            return {
                title: '休闲的五子棋游戏',
                imageUrl: canvas.toTempFilePathSync({
                    destWidth: 500,
                    destHeight: 400
                }),
            }
        });

        // // 点击一个分享按钮直接调用的
        // wx.shareAppMessage({
        //     title: '转发标题',
        //     imageUrl: canvas.toTempFilePathSync({
        //         destWidth: 500,
        //         destHeight: 400
        //     }),
        // });
    },

    start () {

    },

    // update (dt) {},
});
