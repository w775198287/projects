var UiBase = require('UiBase');
var GameData = require('GameData');
var ChessPrefabPath = 'resources/prefabs/chesscell';
var MaxLineNum = 15;
const CHESS_TYPE = cc.Enum({
    NONE: 0,
    BLACK: 1,
    WHITE: 2
});
const CHESS_TYPE_PATH = cc.Enum({
    BLACK: "im_black",
    WHITE: "im_white",
});

cc.Class({
    extends: UiBase,

    properties: {
        boardbg: {
            default: null,
            type: cc.Sprite
        },
        chessparentnode: {
            default: null,
            type: cc.Node
        },
        sidegraphicnode: {
            default: null,
            type: cc.Node
        },
        insidegraphicnode: {
            default: null,
            type: cc.Node
        },

        chessprefab: {
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
        // 线条宽度：外侧
        sidelinewidth: 12,
        // 线条宽度：内侧
        insidelinewidht: 3,
    },

    // LIFE-CYCLE CALLBACKS:

    Init() {
        console.log(" file=ChessBoard  func=Init; ");
        // 按钮等触摸事件监听
        this.boardbg.node.on(cc.Node.EventType.TOUCH_END, this.OnTouchEndEvent, this);

        this.InitUI();
        this.InitData();


        this.AddListenerHandler('createchess', this.OnCreateChess, this);
        this.AddListenerHandler('gamedata_resetall', this.OnResetAll, this);
    },

    InitUI() {
        console.log(" file=ChessBoard  func=Init; ");

        var winSize = cc.director.getWinSize();
        var tSizeWidth = winSize.width;
        var tSizeHeight = winSize.height;

        // 长方形的宽高
        this.sidelength = tSizeWidth - this.edgedistance * 2;
        var tWidth = this.sidelength;
        var tHeight = tWidth;
        var tMinPosX = - tWidth / 2;
        var tMaxPosX = tWidth / 2;
        var tMinPosY = - tHeight / 2;
        var tMaxPosY = tHeight / 2;
        this.boardbg.node.setContentSize(cc.size(tSizeWidth, tSizeHeight));
        this.boardbg.node.setPosition(cc.p(0, 0));

        // :chessparentnode在boardbg棋盘左下角
        this.chessparentnode.setPosition(cc.p(tMinPosX, tMinPosY));
        console.log(" file=ChessBoard  func=Init; tMinPosX=",tMinPosX);
        console.log(" file=ChessBoard  func=Init; tMaxPosX=",tMaxPosX);
        console.log(" file=ChessBoard  func=Init; tMinPosY=",tMinPosY);
        console.log(" file=ChessBoard  func=Init; tMaxPosY=",tMaxPosY);

        var g = this.sidegraphicnode.getComponent(cc.Graphics);
        if (g === undefined) {
            console.log(" file=ChessBoard  func=Init; return 111");
            return;
        }

        g.lineWidth = this.sidelinewidth;
        g.fillColor = cc.hexToColor('#FFD39B');

        //------------------------------绘制棋盘------------------------------
        //-----------------绘制长方形-----------------
        g.rect(- tWidth / 2, - tHeight / 2, tWidth, tHeight);
        // 圆形
        // g.circle(x, ty, radius);

        g.stroke();
        g.fill();

        //-----------------长方形内的线条-----------------
        // 每条线之间的间距;总格子数:MaxLineNum - 1
        var tTotalLines = MaxLineNum;
        // 每个格子边长
        var tStep = tWidth / (tTotalLines - 1);
        var strStep = String(tStep)
        var wx = strStep.indexOf('.');
        if (wx !== -1) {
            tStep = Number(strStep.substring(0, wx+2));
        }
        console.log(" file=ChessBoard  func=Init; tStep 4 == ",tStep);
        this.stepdistance = tStep;
        // 横竖划线条数一样;除去最外面方形的的4条线（长方形），横竖各减去2条
        var tVerticalDrawlines = tTotalLines - 2
        var tHorizontalDrawlines = tTotalLines - 2
        g = this.insidegraphicnode.getComponent(cc.Graphics);
        if (g === undefined) {
            return;
        }
        g.lineWidth = this.insidelinewidht;

        // 竖方向的线
        for (var i = 1; i <= tVerticalDrawlines; i++) {
            console.log(" file=ChessBoard  func=Init; y1 == ",tMinPosY);
            g.moveTo(tMinPosX + tStep * i, tMinPosY);
            console.log(" file=ChessBoard  func=Init; y2 == ",tMaxPosY);
            g.lineTo(tMinPosX + tStep * i, tMaxPosY);
            g.close();
        }
        // 横方向的线
        for (var j = 1; j <= tHorizontalDrawlines; j++) {
            g.moveTo(tMinPosX, tMinPosY + tStep * j);
            g.lineTo(tMaxPosX, tMinPosY + tStep * j);
            g.close();
        }

        var fillColor = cc.Color.RED;//声明一个颜色变量
        fillColor.a = 0;//添加透明度
        g.fillColor = fillColor;//填充

        g.stroke();
        g.fill();
        //------------------------------绘制棋盘------------------------------
    },

    // 数据初始化
    InitData() {
        console.log(" file=ChessBoard  func=InitData; ");

        //棋盘数据： 空、黑、白: 0, 1, 2
        this.miChessData = new Array(MaxLineNum);
        for (let i = 0; i < this.miChessData.length; i++) {
            this.miChessData[i] = new Array(MaxLineNum);
            for (let j = 0; j < this.miChessData[i].length; j++) {
                this.miChessData[i][j] = 0;
            }
        }
        // 谁先开始下
        this.isblackfirst = GameData.miFirstPlayer;
        this.miNextChess = this.isblackfirst;
        GameData.ResetAllData();
    },

    start () {

    },

    // 点击位置下棋
    OnTouchEndEvent: function (event) {
        console.log(" file=ChessBoard  func=OnTouchEndEvent; ");

        var touches = event.getTouches();
        var touchLoc = touches[0].getLocation();
        this.moveToPos = this.chessparentnode.convertToNodeSpaceAR(touchLoc);
        // this.moveToPos = touchLoc;
        var tMinX =  - this.stepdistance / 2;
        var tMaxX = this.sidelength + this.stepdistance / 2;
        var tMinY = tMinX;
        var tMaxY = tMaxX;
        if (this.moveToPos.x < tMinX || this.moveToPos.x > tMaxX || this.moveToPos.y < tMinY || this.moveToPos.y > tMaxY){
            console.log(" file=ChessBoard  func=OnTouchEndEvent return");
            return;
        }

        var strXpos = this.moveToPos.x;
        var strYpos = this.moveToPos.y;
        console.log(" file=ChessBoard  func=OnTouchEndEvent 11 strXpos=",strXpos);
        console.log(" file=ChessBoard  func=OnTouchEndEvent 11 strYpos=",strYpos);
        var tStep = this.stepdistance;
        var tVerticalIndex = parseInt(strXpos / tStep);
        var tVerticalRemaind =  strXpos % tStep;
        if (Math.abs(tVerticalRemaind) > tStep / 2) {
            tVerticalIndex = tVerticalIndex + 1;
        }
        var tHerizontalIndex = parseInt(strYpos / tStep);
        var tHerizontalRemaind = Math.abs(strYpos % tStep);
        if (Math.abs(tHerizontalRemaind) > tStep / 2) {
            tHerizontalIndex = tHerizontalIndex + 1;
        }
    
        console.log(" file=ChessBoard  func=OnTouchEndEvent tVerticalIndex=",tVerticalIndex);
        console.log(" file=ChessBoard  func=OnTouchEndEvent tHerizontalIndex=",tHerizontalIndex);
        var aiData = {
            x : tVerticalIndex,
            y : tHerizontalIndex,
            color : this.miNextChess,
        };
        
        GameData.UpdateChessData(aiData);
    },

    // 绘制黑白棋子
    OnCreateChess: function (event) {
        console.log(" file=ChessBoard  func=OnCreateChess; ");

        // 更换棋子黑白类型
        if (this.miNextChess === CHESS_TYPE.BLACK) {
            this.miNextChess = CHESS_TYPE.WHITE;
        }else{
            this.miNextChess = CHESS_TYPE.BLACK;
        }

        var aiData = event.getUserData();
        if (aiData === undefined){
            return;
        }
        if (aiData.x === undefined || aiData.y === undefined) {
            return;
        }
        if (aiData.color === undefined || aiData.color === CHESS_TYPE.NONE) {
            return;
        }

        var tIconPath = "";
        if (aiData.color === CHESS_TYPE.BLACK){
            tIconPath = CHESS_TYPE_PATH.BLACK;
        }else{
            tIconPath = CHESS_TYPE_PATH.WHITE;
        }

        cc.loader.loadRes(tIconPath, cc.SpriteFrame, function(err, spriteFrame){
            var pChessNode = cc.instantiate(this.chessprefab);
            pChessNode.getComponent(cc.Sprite).spriteFrame = spriteFrame;
            pChessNode.setContentSize(cc.size(40, 40));

            /*创建节点
            var pChessNode = new cc.Node();
            //调用新建的node的addComponent函数，会返回一个sprite的对象  
            const sprite = pChessNode.addComponent(cc.Sprite);
            //给sprite的spriteFrame属性 赋值  
            sprite.spriteFrame = spriteFrame;
            sprite.node.setScale(0.3);
            pChessNode.setContentSize(cc.size(50, 50));
            */
            //最终摆放位置
            var tChessPoint = cc.p(this.stepdistance * aiData.x, this.stepdistance * aiData.y);
            var strXpos = tChessPoint.x.toString();
            var strYpos = tChessPoint.y.toString();
            // var wx = strXpos.indexOf('.');
            // var wy = strYpos.indexOf('.');
            // strXpos = strXpos.substring(0, wx) + strXpos.substring(wx, wx + 3);
            // strYpos = strYpos.substring(0, wy) + strYpos.substring(wy, wy + 3);
            strXpos = strXpos.slice(0, 6);
            strYpos = strYpos.slice(0, 6);
            var tXpos = Number(strXpos);
            var tYpos = Number(strYpos);
            tChessPoint = cc.p(strXpos, strYpos);
            // this.label.string = "x=" + strXpos + "  y=" + strYpos;

            pChessNode.setPosition(cc.p(tXpos, tYpos));
            this.chessparentnode.addChild(pChessNode);

            // 加入棋子容器
            var tlength = this.ChessVector.length;
            this.ChessVector[tlength] = pChessNode;
        }.bind(this));
        
    },



    OnResetAll: function () {
        console.log(" file=ChessBoard  func=OnResetAll; ");

        // 恢复开局谁先下
        this.isblackfirst = GameData.miFirstPlayer;
        // 下一手谁下棋子,  黑、白: 1, 2
        this.miNextChess = this.isblackfirst;
        GameData.ResetAllData();

        // 棋盘容器清空，同时棋子从棋盘移除
        for (let i = 0; i < this.ChessVector.length; i++) {
            if (this.ChessVector[i] !== undefined){
                this.ChessVector[i].removeFromParent();
            }
        }
        this.ChessVector.length = 0;
    },

    // update (dt) {},
});
