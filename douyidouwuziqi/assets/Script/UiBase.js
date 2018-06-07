const i18n = require('LanguageData');

cc.Class({
    extends: cc.Component,

    properties: {
        
    },

    onLoad() {
        i18n.init('en');

        this.Init();
        if (cc.sys.browserType === cc.sys.BROWSER_TYPE_WECHAT_GAME) {
            this.InitWX();
        }
    },

    Init(){
        console.log(" file=UiBase  func=Init");
    },

    InitWX(){
        console.log(" file=UiBase  func=InitWX");
    },

    AddListenerHandler: function(aiType, aiCallBack, aiTarget) {     
        cc.find('Canvas').on(aiType, aiCallBack, aiTarget);
    },

    SendListenerHandler: function(aiType, aiData){
        var tEventCustom = new cc.Event.EventCustom(aiType, false);
        tEventCustom.setUserData(aiData);
        cc.find('Canvas').dispatchEvent(tEventCustom);
    },

    onDestroy(){
    },
});


