
local GameScene = class("GameScene", cc.load("mvc").ViewBase)

GameScene.RESOURCE_FILENAME = "cocosstudio/ui/GameScene.csb"

function GameScene:createBinDing()

    if self.RESOURCE_BINDING then
        return
    end
    local bindings
    local  targetChild 
    targetChild = {
 		TargetPic        = {varname = "TargetPic"},
 		TargetPoint      = {varname = "TargetPoint"},
	}

	local curChild
	curChild = 
    {
 		CurPic           = {varname = "CurPic"},
 		NodeButton       = {varname = "NodeButton",events={{event="touch",method="nodeBtnClick"}}},
        CurDian          = {varname = "CurDian"},
	}

    local positionChild
        
    positionChild = 
    {
 		Title   		= {varname = "Title"},
 		TargetNode		= {varname = "TargetNode", children = targetChild, },
 		CurNode			= {varname = "CurNode", children = curChild,},
 		RightButton		= {varname = "RightButton", events={{ event = "touch", method = "rightBtnClick"}}},
 		LeftButton		= {varname = "LeftButton", events={{ event = "touch", method  = "leftBtnClick"}}},
	}

    bindings = {
        PositionNode = { varname= "PositionNode",children = positionChild},
    }

    self.RESOURCE_BINDING = bindings
end
GameScene:createBinDing()

function GameScene:onCreate()
    

end

function GameScene:onEnter()

end

function GameScene:onExit()

end

function GameScene:onCreateTargetNode()
    -- body
    local TargetNode    = self.PositionNode:getChildByName("TargetNode")
    local TargetPic     = TargetNode:getChildByName("TargetPic")
    local TargetPoint   = TargetNode:getChildByName("TargetPoint")
    local posX          = TargetPoint:getPositionX()
    local posY          = TargetPoint:getPositionY()
    local rotateAction  = cc.RotateBy:create(0.5 ,45)
    local bezier = {
        cc.p(0,0),
        cc.p(0,0),
        cc.p(0,0),
    }
    TargetNode:runAction(rotateAction)
    print("#############  posX:"..posX.."--posY"..posY)
end



function GameScene:refreshPoint(  )
    local curNode = self.PositionNode:getChildByName("CurNode")
    local CurPoint = curNode:getChildByName("CurDian")
    local pointPosY = CurPoint:getPositionY()
    local pointPosX = CurPoint: getPositionX()       
    print("#############  pointPosY:"..pointPosY.."--pointPosX:"..pointPosX)

    -- body
end
function GameScene:leftBtnClick(event)
    print("#######################")
    self:refreshPoint()
    --self:onCreateTargetNode()
end

function GameScene:rightBtnClick(event)
    print("@@@@@@@@@@@@@@@@@@")
end

function GameScene:nodeBtnClick(event)
    print("$$$$$$$$$$$$$$$$$$")
end


return GameScene
