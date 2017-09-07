
friendlyUnitController = {}
friendlyUnitController.units= {}
unit = {}
currentUnit = 1
maxUnits = 2
cooldown = 20
function love.load()
		--sets windowsize to be a perfect square
	windowSize = love.window.setMode(768,768)
--Sets coordinates of squares along the x axis
	mapLength = {0,64,128, 192, 256,320,384,448,512,576,640,704}
--Sets coordinates of squares along the y axis
	mapHeight = {0,64,128, 192, 256,320,384,448,512,576,640,704}
	

------------------------------------------------------------

	--units = {}
	
	friendlyUnitController:spawnUnit(11,0)
	friendlyUnitController:spawnUnit(11,2)
	friendlyUnitController:spawnUnit(11,3)

end

function friendlyUnitController:spawnUnit(x,y)
	--places unit. whatever is needed, variables stored in here that can be edited later
	---Works basically like an object
	unit = {}
	unit.LocationX = (x*64)+16
	unit.LocationY = (y*64) + 16
	unit.movementCooldown = cooldown
	unit.movesleft = 4

	table.insert(self.units, unit)
end
function endturn()
	for _,e in pairs(friendlyUnitController.units) do
		e.movesleft = 4
	end
end
function friendlyUnitController:movement(selectedUnit, direction)
	if (friendlyUnitController.units[currentUnit].movementCooldown<=0) then
		friendlyUnitController.units[currentUnit].movementCooldown=12
		if(friendlyUnitController.units[selectedUnit].movesleft>0) then
		
			if(direction=="left") then
				friendlyUnitController.units[selectedUnit].LocationX = friendlyUnitController.units[selectedUnit].LocationX - 64
				friendlyUnitController.units[selectedUnit].movesleft = friendlyUnitController.units[selectedUnit].movesleft - 1
			elseif(direction=="right") then
				friendlyUnitController.units[selectedUnit].LocationX = friendlyUnitController.units[selectedUnit].LocationX + 64
				friendlyUnitController.units[selectedUnit].movesleft = friendlyUnitController.units[selectedUnit].movesleft - 1
			elseif(direction == "up" ) then
				friendlyUnitController.units[selectedUnit].LocationY = friendlyUnitController.units[selectedUnit].LocationY - 64
				friendlyUnitController.units[selectedUnit].movesleft = friendlyUnitController.units[selectedUnit].movesleft - 1
			elseif(direction == "down") then
				friendlyUnitController.units[selectedUnit].LocationY = friendlyUnitController.units[selectedUnit].LocationY + 64
				friendlyUnitController.units[selectedUnit].movesleft = friendlyUnitController.units[selectedUnit].movesleft - 1
			end

		end

			if(direction=="space") then
				if((currentUnit<=maxUnits)) then
					currentUnit = currentUnit + 1
					print(currentUnit)
			
			--print(currentUnit)

		
	
				else	
				--print(currentUnit)
					currentUnit=1
					print(currentUnit)
				end	
	
			end
	end	
	if(direction == "enter") then
		endturn()
	end
end

innerTileOne = love.graphics.newImage("InnerTile1.png")
rightTileEdge = love.graphics.newImage("RightWall.png")
characterModel = love.graphics.newImage("Soldier.png")

function  love.update(dt)
	friendlyUnitController.units[currentUnit].movementCooldown = friendlyUnitController.units[currentUnit].movementCooldown - 1
	
	if(love.keyboard.isDown("left")) then
		friendlyUnitController:movement(currentUnit,"left")
		--friendlyUnitController.units.movementCooldown=10
		
	
	elseif(love.keyboard.isDown("right")) then
		
		friendlyUnitController:movement(currentUnit,"right")
		--friendlyUnitController.units.movementCooldown=10
	
	elseif(love.keyboard.isDown("up")) then
		friendlyUnitController:movement(currentUnit, "up")	
	--	friendlyUnitController.units.movementCooldown=10
	elseif(love.keyboard.isDown("down")) then
		friendlyUnitController:movement(currentUnit, "down")	
		--friendlyUnitController.units.movementCooldown=10
	elseif(love.keyboard.isDown("space")) then
			friendlyUnitController:movement(currentUnit, "space")
	elseif(love.keyboard.isDown("return")) then
			friendlyUnitController:movement(currentUnit, "enter")

	end

end

function love.draw()
	--love.graphics.setColor(89,58,94)
	--love.graphics.rectangle("fill", 0,0,64,64)
	--love.graphics.rectangle("fill", 64,0,64,64)
	for i = 1, 12 do
		for y = 1, 12 do
			--love.graphics.rectangle("fill", mapLength[i],mapHeight[y],64,64)
			if(mapLength[i]==704) then
					love.graphics.draw(rightTileEdge, mapLength[i], mapHeight[y])
			
			else
				love.graphics.draw(innerTileOne, mapLength[i], mapHeight[y])
			end
		end
		
	end
	

	for _,e in pairs(friendlyUnitController.units) do
		--print(e.LocationX)
		love.graphics.draw(characterModel, e.LocationX,e.LocationY)
	end

end