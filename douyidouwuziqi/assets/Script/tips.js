var UiBase = require('UiBase');
const SHOW_TYPE = cc.Enum({
    ONE: 1,
    TWO: 2,
});
var tips = cc.Class({
    extends: UiBase,

    properties: {
        tipnodeone: {
            default: null,
            type: cc.Node
        },
        btnconfirm: {
            default: null,
            type: cc.Button
        },
        tipnodetwo: {
            default: null,
            type: cc.Node
        },
        btnback: {
            default: null,
            type: cc.Button
        },
        btncontinue: {
            default: null,
            type: cc.Button
        },
    },

    // LIFE-CYCLE CALLBACKS:

    onLoad: function() {
        this.btnconfirm.node.on('click', this.onBtnConfirm, this);
        this.btnback.node.on('click', this.onBtnBack, this);
        this.btncontinue.node.on('click', this.onBtnContinue, this);

        this.tipnodeone.active = false;
        this.tipnodetwo.active = false;

        this.AddListenerHandler('showid', this.showTipsNode);
    },

    AddListenerHandler: function(aiType, aiCallBack) {
        var that = this;      
        cc.find('Canvas').on(aiType, aiCallBack, that);
    },

    // 确定按钮
    onBtnConfirm: function(event) {
        console.log(" file=tips  func=onBtnConfirm");
        this.node.active = false
    },

    // 退出按钮
    onBtnBack: function(event) {
        console.log(" file=tips  func=onBtnBack");
        this.node.active = false


        var tEventCustom_Tips = new cc.Event.EventCustom("backtohall", false);
        tEventCustom_Tips.setUserData({isGameOver : true});
        cc.find('Canvas').dispatchEvent(tEventCustom_Tips);
    },

    // 继续按钮
    onBtnContinue: function(event) {
        console.log(" file=tips  func=onBtnContinue");
        this.node.active = false

        // 通知：弹出结果界面
        var tEventCustom_Tips = new cc.Event.EventCustom("gamedata_resetall", false);
        tEventCustom_Tips.setUserData({isGameOver : true});
        cc.find('Canvas').dispatchEvent(tEventCustom_Tips);
    },

    showTipsNode: function(event) {
        console.log(" file=tips  func=showTipsNode");

        var aiData = event.getUserData();
        if (aiData === undefined || aiData.showid === undefined) {
            return;
        }
        this.node.active = true;
        this.tipnodeone.active = false;
        this.tipnodetwo.active = false;
        var aiNum = Number(aiData.showid);

        if (aiNum === SHOW_TYPE.ONE) {
            this.tipnodeone.active = true;
            this.tipnodetwo.active = false;
        }else if(aiNum === SHOW_TYPE.TWO){
            this.tipnodeone.active = false;
            this.tipnodetwo.active = true;
        }
    },

    onDestroy(){
        console.log(" file=tips  func=onDestroy");
    },

    // update (dt) {},
});
