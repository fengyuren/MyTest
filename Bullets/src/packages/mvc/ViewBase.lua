
local ViewBase = class("ViewBase", cc.Node)

function ViewBase:ctor(app, name)
    self:enableNodeEvents()
    self.app_ = app
    self.name_ = name

    -- check CSB resource file
    local res = rawget(self.class, "RESOURCE_FILENAME")
    if res then
        self:createResoueceNode(res)
    end

    local binding = rawget(self.class, "RESOURCE_BINDING")
    if res and binding then
        self:createResoueceBinding(binding)
    end
    
    if self.onCreate then self:onCreate() end
end

function ViewBase:getApp()
    return self.app_
end

function ViewBase:getName()
    return self.name_
end

function ViewBase:getResourceNode()
    return self.resourceNode_
end

function ViewBase:createResoueceNode(resourceFilename)
    print("#################### resourceFilename:"..tostring(resourceFilename))
    if self.resourceNode_ then
        self.resourceNode_:removeSelf()
        self.resourceNode_ = nil
    end
    self.resourceNode_ = cc.CSLoader:createNode(resourceFilename)
    assert(self.resourceNode_, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", resourceFilename))
    self:addChild(self.resourceNode_)
end

function ViewBase:createResoueceBinding(binding)
    assert(self.resourceNode_, "ViewBase:createResoueceBinding() - not load resource node")
    self:createChildResourceBinding(self.resourceNode_, binding, nil, self)
    --[[
    for nodeName, nodeBinding in pairs(binding) do
        local node = self.resourceNode_:getChildByName(nodeName)
        if nodeBinding.varname then
            self[nodeBinding.varname] = node
        end
        for _, event in ipairs(nodeBinding.events or {}) do
            if event.event == "touch" then
                node:onTouch(handler(self, self[event.method]))
            end
        end
    end
    ]]
end

function ViewBase:createChildResourceBinding(node, binding, varTable, root)
    for nodeName, nodeBinding in pairs(binding) do
        local  childNode = node:getChildByName(nodeName)
        if nodeBinding.varname then
            if varTable then
                varTable[nodeBinding.varname] = childNode
            else
                if root then
                    root[nodeBinding.varname] = childNode 
                else
                    root[nodeBinding.varname] = childNode 
                end
            end
        end

        local  childVarTable
        if nodeBinding.varTable then 
            childVarTable = {}
            if varTable then
                varTable[nodeBinding.varTable] = childVarTable
            else
                if root then 
                    varTable[nodeBinding.varTable] = childVarTable
                else
                    varTable[nodeBinding.varTable] = childVarTable
                end
            end
        end
        if nodeBinding.text then
            childNode:setString("wwwwwwwwwww")
        end
        if nodeBinding.title then 
            childNode:setTitleText("vvvvvvvv")
        end
        if nodeBinding.outLineColor and nodeBinding.outLineSize then 
            local titleRenderer = childNode:getTieleRenderer()
            titleRenderer:enableOutLine(nodeBinding.outLineColor, nodeBinding.outLineSize)
        end
        if nodeBinding.pressedActtion then 
            childNode:setPressedActionEnable(true)
        end
        if nodeBinding.events then 
            for _, event in ipairs(nodeBinding.events) do
                if event.event == "touch" then 
                    childNode:onTouch(handler(self, self[event.method]))
                elseif event.event == "clicked" then 
                    childNode:onTouch(handler(self, self[event.method]))
                elseif event.event == "event" then 
                    childNode:onTouch(handler(self, self[event.method]))
                elseif event.event == "scroll" then 
                    childNode:onTouch(handler(self, self[event.method]))
                end
            end
        end
        if nodeBinding.children then 
            self:createChildResourceBinding(childNode, nodeBinding.children, childVarTable, root)
        end
    end
end

function ViewBase:showWithScene(transition, time, more)
    self:setVisible(true)
    local scene = display.newScene(self.name_)
    scene:addChild(self)
    display.runScene(scene, transition, time, more)
    return self
end

return ViewBase
