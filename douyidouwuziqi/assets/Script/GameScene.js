var UiBase = require('UiBase');
const i18n = require('LanguageData');

const SHOW_TYPE = cc.Enum({
    ONE: 1,
    TWO: 2,
});

const WX_TYPE_ENUM = cc.Enum({
    WXNODE_VISIBLE_SHOW : 1,    //显示排行榜
    WXNODE_VISIBLE_HIDE : 2,    //隐藏排行榜
    WXNODE_SHARE : 3,           //调起微信分享
});

cc.Class({
    extends: UiBase,

    properties: {
        label: {
            default: null,
            type: cc.Label
        },
        boardnode: {
            default: null,
            type: cc.Node
        },
        btnbacktohall: {
            default: null,
            type: cc.Button
        },
        btnrank: {
            default: null,
            type: cc.Button
        },
        bgrank: {
            default: null,
            type: cc.Sprite
        },
        boardprefab: {
            default: null,
            type: cc.Prefab
        },
        tipsprefab: {
            default: null,
            type: cc.Prefab
        },


        // 存放棋子的容器
        ChessVector: {
            default: [],
            type: [cc.Node]
        },

        // 距离屏幕边距
        edgedistance: 50,
        // 棋盘宽高
        sidelength: 800,
        // 线条位置间距
        stepdistance: 0,

        sidelinewidth: 12,
        // 绘制棋子的半径:决定棋子的大小
        chessradius: 15,
        // 定义每一局开始谁先下棋子
        isblackfirst: true,
    },

    // use this for initialization
    Init() {
        console.log(" file=GameScene  func=Init");

        i18n.init('en');
        this.label.string = i18n.t('label_text.hello');;
        // 棋盘
        var tBoard = cc.instantiate(this.boardprefab).getComponent('ChessBoard');
        this.boardnode.addChild(tBoard.node);

        // 初始化tipsnode
        this.miTipsNode = cc.instantiate(this.tipsprefab);
        this.miTipsNode.active = false;
        this.miTipsNode.parent = this.node;

        this.btnbacktohall.node.on(cc.Node.EventType.TOUCH_END, this.onBtnBackEvent, this);
        this.btnrank.node.on(cc.Node.EventType.TOUCH_END, this.OnBtnRankEvent, this);

        // 注册事件监听
        this.AddListenerHandler('errorpos', this.OnErrorPostion, this);
        this.AddListenerHandler('gameover', this.OnGameOVer, this);
        this.AddListenerHandler('backtohall', this.onBtnBackEvent, this);
    },

    InitWX() {
        console.log(" file=GameScene  func=InitWX");

        // 排行榜按钮隐藏
        this.btnrank.active = true;

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
        console.log(" file=GameScene  func=start");
    },

    onBtnBackEvent: function(event) {
        console.log(" file=GameScene  func=onBtnBackEvent");

        cc.director.loadScene("loadscene");
    },

    OnBtnRankEvent: function (event) {
        console.log(" file=GameScene  func=OnBtnRankEvent");

        this.isShow = true;
        this.tex = new cc.Texture2D();

        // this.isShow = !this.isShow;
        // 发消息给子域
        wx.postMessage({
            message: this.isShow ? WX_TYPE_ENUM.WXNODE_VISIBLE_SHOW : WX_TYPE_ENUM.WXNODE_VISIBLE_HIDE,
        });
    },

    // 游戏结束
    OnGameOVer: function(event) {
        console.log(" file=GameScene  func=OnGameOVer");

        var aiData = event.getUserData()
        if (aiData !== undefined && aiData.isGameOver !== undefined && aiData.isGameOver === true) {
            this.miTipsNode.active = true;
            // 通知：弹出结果界面
            var tData = {showid : SHOW_TYPE.TWO}
            this.SendListenerHandler("showid", tData);
        }
    },

    // 位置错误
    OnErrorPostion: function (event) {
        console.log(" file=GameScene  func=OnErrorPostion");

        var aiData = event.getUserData()
        if (aiData !== undefined && aiData.errorcode !== undefined) {
            this.miTipsNode.active = true;
            // 通知：弹出结果界面
            var tData = {showid : SHOW_TYPE.ONE};
            this.SendListenerHandler("showid", tData);
        }
    },

    updateSubDomainCanvas: function() {
        console.log(" file=GameScene  func=updateSubDomainCanvas");

        if (cc.sys.browserType !== cc.sys.BROWSER_TYPE_WECHAT_GAME) {
            return
        }
        if (!this.tex) {

            console.log(" file=GameScene  func=updateSubDomainCanvas return");
            return;
        }

        console.log(" file=GameScene  func=updateSubDomainCanvas 111");
        var openDataContext = wx.getOpenDataContext();
        var sharedCanvas = openDataContext.canvas; 
        this.tex.initWithElement(sharedCanvas);
        this.tex.handleLoadedTexture();
        this.bgrank.spriteFrame = new cc.SpriteFrame(this.tex);
        this.bgrank.node.active = true;
    },

    // called every frame
    update: function (dt) {
        if (cc.sys.browserType === cc.sys.BROWSER_TYPE_WECHAT_GAME) {
            this.updateSubDomainCanvas();
        }
    },

    onDestroy(){
        console.log(" file=GameScene  func=onDestroy");
        this.miTipsNode.removeFromParent();
    },
});


