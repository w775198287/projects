var GameData = require('GameData');
var MaxLineNum = 15;
cc.Class({
    extends: cc.Component,

    properties: {
        label: {
            default: null,
            type: cc.Label
        },
        boardrootnode: {
            default: null,
            type: cc.Node
        },
        graphicsnode: {
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
        bgimage: {
            default: null,
            type: cc.Sprite
        },
        btnreset: {
            default: null,
            type: cc.Button
        },
        btnbacktohall: {
            default: null,
            type: cc.Button
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
        insidelinewidht: 3,
        // 绘制棋子的半径:决定棋子的大小
        chessradius: 15,
        // 定义每一局开始谁先下棋子
        isblackfirst: true,
        

    },

    // use this for initialization
    onLoad: function () {
        this.label.string = "Hello, World!";

        //棋盘数据： 空、黑、白: 0, 1, 2
        this.miChessData = new Array(MaxLineNum);
        for (let i = 0; i < this.miChessData.length; i++) {
            this.miChessData[i] = new Array(MaxLineNum);
            for (let j = 0; j < this.miChessData[i].length; j++) {
                this.miChessData[i][j] = 0;
            }
        }

        
        // 下一手谁下棋子,  黑、白: 1, 2
        if (this.isblackfirst == true) {
            this.miNextChess = 1;
        }
        

        // 初始化棋盘绘制节点，并绘制棋盘
        this.initChessBoard();
        GameData.resetAllData();

        this.bgimage.node.on(cc.Node.EventType.TOUCH_END, this.OnTouchEndEvent, this);
        this.btnbacktohall.node.on(cc.Node.EventType.TOUCH_END, this.OnTouchEndEvent, this);
        this.btnreset.node.on('click', this.onBtnResetHandler, this);

        this.node.on('addChessNode', this.createChess);
    },

    // 绘制棋盘
    initChessBoard: function () {
        console.log("initChessBoard");

        var winSize = cc.director.getWinSize();
        var tSizeWidth = winSize.width;
        var tSizeHeight = winSize.height;
        console.log("initChessBoard  visibleSize.width = ", winSize.width);
        console.log("initChessBoard  visibleSize.height = ", winSize.height);

        // 长方形的宽高
        this.sidelength = tSizeWidth - this.edgedistance * 2;
        var tWidth = this.sidelength;
        var tHeight = tWidth;

        // boardrootnode:棋盘左下角:graphicsnode成为原点(0，0)
        var tXpos = -(tSizeWidth / 2 - this.edgedistance)
        var tYpos = -tHeight / 2
        this.boardrootnode.setPosition(cc.p(tXpos, tYpos));

        var g = this.sidegraphicnode.getComponent(cc.Graphics);
        if (g === null) {
            console.log("initChessBoard  return 111");
            return;
        }

        g.lineWidth = this.sidelinewidth;
        g.fillColor = cc.hexToColor('#FFD39B');

        //------------------------------绘制棋盘------------------------------
        //-----------------绘制长方形-----------------
        g.rect(0, 0, tWidth, tHeight);
        // 圆形
        // g.circle(x, ty, radius);

        g.stroke();
        g.fill();

        //-----------------长方形内的线条-----------------
        // 每条线之间的间距;总格子数:MaxLineNum - 1
        var tTotalLines = MaxLineNum;
        var tStep = tWidth / (tTotalLines - 1);
        this.stepdistance = tStep;
        console.log("initChessBoard  tStep = ",tStep);
        // 横竖划线条数一样;除去最外面方形的的4条线（长方形），横竖各减去2条
        var tVerticalDrawlines = tTotalLines - 2
        var tHorizontalDrawlines = tTotalLines - 2
        g = this.insidegraphicnode.getComponent(cc.Graphics);
        if (g === null) {
            console.log("initChessBoard  return 111");
            return;
        }
        g.lineWidth = this.insidelinewidht;

        // 竖方向的线
        for (var i = 1; i <= tVerticalDrawlines; i++) {
            g.moveTo(tStep * i, 0);
            g.lineTo(tStep * i, tHeight);
            g.close();
        }
        // 横方向的线
        for (var j = 1; j <= tHorizontalDrawlines; j++) {
            g.moveTo(0, tStep * j);
            g.lineTo(tWidth, tStep * j);
            g.close();
        }

        var fillColor = cc.Color.RED;//声明一个颜色变量
        fillColor.a = 0;//添加透明度
        g.fillColor = fillColor;//填充

        g.stroke();
        g.fill();
        //------------------------------绘制棋盘------------------------------
    },

    // 点击位置下棋
    OnTouchEndEvent: function (event) {
        console.log("OnTouchEndEvent...");
        if (this.miBlackDrawGraphic === null || this.miWhiteDrawGraphic === null) {
            console.log("OnTouchEndEvent... black or white graphic is null");
            return;
        }

        var touches = event.getTouches();
        var touchLoc = touches[0].getLocation();
        this.isMoving = true;
        this.moveToPos = this.graphicsnode.convertToNodeSpaceAR(touchLoc);
        if (this.moveToPos.x < 0 || this.moveToPos.x > this.sidelength || this.moveToPos.y < 0 || this.moveToPos.y > this.sidelength){
            console.log("OnTouchEndEvent...超出棋盘");
            return;
        }
        var strXpos = this.moveToPos.x;
        var strYpos = this.moveToPos.y;

        var tStep = this.stepdistance
        var tVerticalIndex = Math.floor(strXpos / tStep);
        var tVerticalRemaind = strXpos % tStep;
        if (tVerticalRemaind > 25) {
            tVerticalIndex = tVerticalIndex + 1;
        }
        var tHerizontalIndex = Math.floor(strYpos / tStep);
        var tHerizontalRemaind = strYpos % tStep;
        if (tHerizontalRemaind > 25) {
            tHerizontalIndex = tHerizontalIndex + 1;
        }
    
        var aiData = {
            x : tVerticalIndex,
            y : tHerizontalIndex
        };

        var tData = GameData.updateChessData(aiData);
        if (tData !== null && tData.isOver !== null && tData.isOver !== true){
            var tChessPoint = cc.p(0, 0);
            var xPos = 0;
            var yPos = 0;
            //最终摆放位置
            var tChessPoint = cc.p(this.stepdistance * tVerticalIndex, this.stepdistance * tHerizontalIndex);
            strXpos = tChessPoint.x.toString();
            strYpos = tChessPoint.y.toString();
            strXpos = strXpos.slice(0, 6);
            strYpos = strYpos.slice(0, 6);
            this.label.string = "x=" + strXpos + "  y=" + strYpos;

            if (tChessPoint.x >= 0 && tChessPoint.x <= this.sidelength && tChessPoint.y >= 0 && tChessPoint.y <= this.sidelength) {
                this.createChess()
            }
        }

        // if (this.miChessData[tVerticalIndex][tHerizontalIndex] !== 0) {
        //     console.log("OnTouchEndEvent...已经放置了棋子，请在未放置的地方重新下棋");
        //     return;
        // }
        // var tChessPoint = cc.p(0, 0);
        // var xPos = 0;
        // var yPos = 0;
        // //最终摆放位置
        // var tChessPoint = cc.p(this.stepdistance * tVerticalIndex, this.stepdistance * tHerizontalIndex);
        // strXpos = tChessPoint.x.toString();
        // strYpos = tChessPoint.y.toString();
        // strXpos = strXpos.slice(0, 6);
        // strYpos = strYpos.slice(0, 6);
        // this.label.string = "x=" + strXpos + "  y=" + strYpos;

        // if (tChessPoint.x >= 0 && tChessPoint.x <= this.sidelength && tChessPoint.y >= 0 && tChessPoint.y <= this.sidelength) {
        //     this.createChess(tChessPoint);

        //     // 更新棋盘数据
        //     this.miChessData[tVerticalIndex][tHerizontalIndex] = this.miNextChess;
        //     // 判断输赢
        //     if (gamereswin == null){
        //         console.log("gamereswin == null");
        //     }
        //     var isGameEnd = GameData.isWin(tVerticalIndex, tHerizontalIndex, this.miNextChess, this.miChessData);
        //     if (isGameEnd === true){
        //         console.log("本局游戏结束，请点击重置开始下一局, 祝您好运!");
        //         return;
        //     }
            
        //     if (this.miNextChess == 1) {
        //         this.miNextChess = 2;
        //     } else {
        //         this.miNextChess = 1;
        //     }
        // }
    },

    // 绘制黑白棋子
    createChess: function (tPoint) {
        console.log("createChess... miNextChess=", this.miNextChess);

        var tIconPath = "";
        if (this.miNextChess == 1){
            tIconPath = "im_black";
        }else{
            tIconPath = "im_white";
        }

        cc.loader.loadRes(tIconPath, cc.SpriteFrame, function(err, spriteFrame){

            var pChessNode = new cc.Node();
            //调用新建的node的addComponent函数，会返回一个sprite的对象  
            const sprite = pChessNode.addComponent(cc.Sprite);
            //给sprite的spriteFrame属性 赋值  
            sprite.spriteFrame = spriteFrame;
            // sprite.node.setScale(0.3);
            sprite.node.setScale(0.3);
            sprite.node.setContentSize(cc.size(70, 70));

            //把新的节点追加到self.node节点去。self.node，就是脚本挂载的节点 
            pChessNode.setPosition(tPoint);
            this.graphicsnode.addChild(pChessNode);

            // 加入棋子容器
            var tlength = this.ChessVector.length;
            this.ChessVector[tlength] = pChessNode;
        }.bind(this));
        
    },

    resetAll: function () {
        console.log("resetAll...");

        // 恢复开局谁先下
        if (this.isblackfirst == true) {
            this.miNextChess = 1;
        }
        // 棋盘容器清空，同时棋子从棋盘移除
        for (let i = 0; i < this.ChessVector.length; i++) {
            if (this.ChessVector[i] !== null){
                this.ChessVector[i].removeFromParent();
            }
        }
        this.ChessVector.length = 0;
    },

    onBtnResetHandler: function(event) {
        console.log("onBtnResetHandler...");
        this.resetAll();
    },

    onBtnBackToHallHandler: function(event) {
        console.log("onBtnBackToHallHandler...");
        cc.director.loadScene("helloworld");
    },

    // called every frame
    update: function (dt) {

    },
});


