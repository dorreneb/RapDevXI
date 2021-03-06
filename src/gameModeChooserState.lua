local framework = require('framework')

local chooser = function()
    local base = {}
    base.modeNames = require('gameModes')
    
    setmetatable(base, framework.parentGame)
    base.currentPosition = 1
    base.done = false
    base.isDone = function(self)
        return self.done
    end

    base.draw = function(self, dt)
        love.graphics.setColor(255,255,255)
        output = self.currentPosition..": "
        output = output..self.modeNames[self.currentPosition]
        love.graphics.print(output, 10, love.graphics.getHeight()/2)
        love.graphics.print("PRESS ENTER TO CONTINUE", 10, (love.graphics.getHeight()/2)+20)
    end 

    base.keypressed = function(self, key)
        if key == 'up' then
            self.currentPosition = ((self.currentPosition -2) % #self.modeNames)+1
        end
        if key == 'down' then
            self.currentPosition = ((self.currentPosition) % #self.modeNames)+1
        end
        if key == 'return' then
            framework.gameMode = require('gameModes/'..self.modeNames[self.currentPosition])()
			framework.gameMode:setGameList(framework.gameList)
            self.done = true
        end
    end 
    framework.mode = framework.modes.rungames
	
	framework.limit = -1 --About to be in the game mode chooser - need to be unlimited time
    return base
end

framework.modes.chooser = chooser