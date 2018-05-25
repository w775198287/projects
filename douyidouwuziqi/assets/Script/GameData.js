var MaxLineNum = 15;
const CHESS_TYPE = cc.Enum({
    NONE: 0,
    BLACK: 1,
    WHITE: 2
});

var GameData = {
    
    miChessData : [],
    miWinner : 0,
    miFirstPlayer : CHESS_TYPE.BLACK,
    miCurChessType : CHESS_TYPE.BLACK,

    // 棋盘数据： 空、黑、白: 0, 1, 2
    resetAllData: function(){
        console.log("------------ resetAllData ------------");
        for (let i = 0; i < MaxLineNum; i++) {
            this.miChessData[i] = new Array(MaxLineNum);
            for (let j = 0; j < this.miChessData[i].length; j++) {
                console.log("------------ resetAllData j=", j);
                this.miChessData[i][j] = CHESS_TYPE.NONE;
            }
        }
    },

    updateChessData: function(aiData){
        var tData = {
            isOver : false,
            isCreate : false,
        }

        if (aiData == null) {
            return;
        }

        if (aiData.x == null || aiData.x < 0 || aiData.x >= MaxLineNum){
            return;
        }

        console.log("------------ aiData.x=", aiData.x);

        if (aiData.y == null || aiData.y < 0 || aiData.y >= MaxLineNum){
            return;
        }

        console.log("------------ aiData.y=", aiData.y);
        

        if (this.miCurChessType !== CHESS_TYPE.NONE && this.miChessData[aiData.x][aiData.y] === this.miCurChessType){
            console.log("------------请在正确的地方下棋------------");
            return;
        }

        this.miChessData[aiData.x][aiData.y] = this.miCurChessType;
        // 发送创建棋子

        // 更换棋子黑白类型
        if (this.miCurChessType === CHESS_TYPE.BLACK) {
            this.miCurChessType = CHESS_TYPE.WHITE;
        }else{
            this.miCurChessType = CHESS_TYPE.BLACK;
        }

        // 创建棋子

        
        // 检测游戏是否结束
        var tIsGameOver = this.checkIsGameOver(aiData.x, aiData.y, this.miCurChessType, this.miChessData);
        if (tIsGameOver === true){
            this.miWinner = this.miCurChessType;
            console.log("------------游戏结束------------");
            // 通知：弹出结果界面
            tData.isOver = true;
            return tData
        }else{
            // 继续游戏
            console.log("------------游戏继续------------");
            tData.isOver = false;
            tData.isCreate = true;
        }
    },

    checkIsGameOver: function(x, y, color, chessboard){
        var N = MaxLineNum-1;
        var dx = new Array(1, 0, 1, 1);
        var dy = new Array(0, 1, 1, -1);
        
        for (let i = 0; i < 4; i++) {
            var sum = 1;
            var tx = x + dx[i];
            var ty = y + dy[i];
            var n = 0;
            while(tx >= 0 && tx <= N && ty >= 0 && ty <= N && chessboard[x][y] == color && n <= 5){
                tx = tx + dx[i];
                ty = ty + dy[i];
                sum = sum + 1;
                n = n + 1;
            }
            tx = x - dx[i];
            ty = y - dy[i];
            n = 0;
            while(tx >= 0 && tx <= N && ty >= 0 && ty <= N && chessboard[x][y] == color && n <= 5){
                tx = tx - dx[i];
                ty = ty - dy[i];
                sum = sum + 1;
                n = n + 1;
            }
    
            if (sum >= 5) {
                return true;
            }
        }
        return false;
    },
}
module.exports = GameData;