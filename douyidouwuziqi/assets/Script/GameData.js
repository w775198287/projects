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

    // 棋盘数据： 空、黑、白: 0, 1, 2
    ResetAllData: function(){
        for (let i = 0; i < MaxLineNum; i++) {
            this.miChessData[i] = new Array(MaxLineNum);
            for (let j = 0; j < this.miChessData[i].length; j++) {
                this.miChessData[i][j] = CHESS_TYPE.NONE;
            }
        }
    },

    UpdateChessData: function(aiData){
        console.log(" file=GameData  func=UpdateChessData; ");
        if (aiData == undefined) {
            return;
        }

        if (aiData.x == undefined || aiData.x < 0 || aiData.x >= MaxLineNum){
            return;
        }

        if (aiData.y == undefined || aiData.y < 0 || aiData.y >= MaxLineNum){
            return;
        }
        

        if (aiData.color == undefined || aiData.color === CHESS_TYPE.NONE || (this.miChessData[aiData.x][aiData.y] !== CHESS_TYPE.NONE)){
            var tEventCustom_ErrorPos = new cc.Event.EventCustom("errorpos", false);
            tEventCustom_ErrorPos.setUserData({errorcode: 1001});
            cc.find('Canvas').dispatchEvent(tEventCustom_ErrorPos);
            return;
        }

        this.miChessData[aiData.x][aiData.y] = aiData.color;
        // 发送创建棋子
        var tEventCustom = new cc.Event.EventCustom("createchess", false);
        tEventCustom.setUserData(aiData);
        cc.find('Canvas').dispatchEvent(tEventCustom);

        // 检测游戏是否结束
        var tIsGameOver = this.CheckIsGameOver(aiData.x, aiData.y, aiData.color, this.miChessData);
        if (tIsGameOver === true){
            // 继续游戏
            this.miWinner = this.miCurChessType;
            var tEventCustom_GameOver = new cc.Event.EventCustom("gameover", false);
            tEventCustom_GameOver.setUserData({isGameOver : true});
            cc.find('Canvas').dispatchEvent(tEventCustom_GameOver);
        }else{
            // 继续游戏
        }
    },

    CheckIsGameOver: function(x, y, color, chessboard){
        var N = MaxLineNum-1;
        var dx = new Array(1, 0, 1, 1);
        var dy = new Array(0, 1, 1, -1);

        for (let i = 0; i < 4; i++) {
            var sum = 1;
            var tx = x + dx[i];
            var ty = y + dy[i];
            var n = 0;

            while(tx >= 0 && tx <= N && ty >= 0 && ty <= N && n <= 5){
                if (chessboard[tx][ty] !== color) {
                    break;
                }
                sum = sum + 1;
                n = n + 1;

                tx = tx + dx[i];
                ty = ty + dy[i];
            }

            tx = x - dx[i];
            ty = y - dy[i];
            n = 0;
            while(tx >= 0 && tx <= N && ty >= 0 && ty <= N && n <= 5){
                if (chessboard[tx][ty] !== color) {
                    break;
                }
                sum = sum + 1;
                n = n + 1;

                tx = tx - dx[i];
                ty = ty - dy[i];
            }

            if (sum >= 5) {
                return true;
            }
        }
        return false;
    },
}

module.exports = GameData;