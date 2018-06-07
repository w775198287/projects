const DATA_TYPE_ENUM = cc.Enum({
    WXNODE_VISIBLE_SHOW : 1,    //显示排行榜
    WXNODE_VISIBLE_HIDE : 2,    //隐藏排行榜
    WXNODE_SHARE : 3,           //调起微信分享
});
cc.Class({
    extends: cc.Component,

    properties: {
        
    },

    // LIFE-CYCLE CALLBACKS:

    onLoad () {
        this.miIsSytemWX = false;
        if (window.wx) {
            this.miIsSytemWX = true;
        }
    },

    start () {
        if(this.miIsSytemWX){
            switch (data.message) {
                case WXNODE_VISIBLE_SHOW:
                    this.OnSetWXNodeVisible(true);
                    break;
                case WXNODE_VISIBLE_HIDE:
                    this.OnSetWXNodeVisible(false);
                    break;
                case WXNODE_SHARE:
                    this.OnShare();
                    break;
                default:
                    break;
            }
        }
    },

    // 发送通知
    OnSetWXNodeVisible(aiVisible){
        
    },

    // 分享
    OnShare(aiData){
        
    },

    // 刷新
    OnUpdateEventListener(){

    },

    update (dt) {
        if(this.miIsSytemWX){
            this.OnUpdateEventListener();
        }
    },
});
