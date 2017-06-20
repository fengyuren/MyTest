    
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

MainScene.RESOURCE_FILENAME = "cocosstudio/ui/MainScene.csb"

MainScene.RESOURCE_BINDING =
{
    ["Button"]   = {["varname"] = "Button",["events"]={{["event"]="touch",["method"]="OnBtnClick"}}},
}

function MainScene:onCreate()
    printf("resource node = %s", tostring(self:getResourceNode()))
    
    --[[ you can create scene with following comment code instead of using csb file.
    -- add background image
    display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)
    ]]
end
function MainScene:OnBtnClick(event)
    print("@@@@@@@@@@@@@@@@@@")
    self:getApp():enterScene("GameScene")   -- 进入游戏界面
end
return MainScene
