local Background = require( "src.Background" )
local Button = require( "src.Button" )
local Camera = require( "src.Camera" )
local Character = require( "src.Character" )
local composer = require( "composer" )
local Ground = require( "src.Ground" )
local GroundBlock = require( "src.GroundBlock" )
local physics = require( "physics" )
local scene = composer.newScene()
local WoodObstacle = require( "src.WoodObstacle" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local bg, camera, ground, mowgli, tiger, time, timeText, timerID, bgMusic, obstacles

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    bg = Background:new(sceneGroup)

    bg:addLayer('assets/backgrounds/plx-1.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-2.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-3.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-4.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-5.png', display.contentWidth, display.contentHeight)

    camera = Camera:new(sceneGroup)

    ground = Ground:new(camera)

    jumpButton = Button:new("assets/buttons/up.png", 64, 64)

    mowgli = Character:new( "mowgli", camera)
    mowgli:setSprite("assets.pg.pg-sprites", "assets/pg/pg-sprites.png", 800)

    tiger = Character:new( "tiger", camera)
    tiger:setSprite("assets.tiger.tiger-sheet", "assets/tiger/tiger-sheet.png", 400)

    bgMusic = audio.loadSound( "assets/audio/bg.mp3" )
end

-- enterFrame() method is called once per frame
function scene:enterFrame()

    if mowgli.pv > 0 then
        ground:update()

        -- line = nil

        for i, obstacle in ipairs(obstacles) do
            if obstacle.sprite.y > display.contentWidth then
                obstacle:delete()
                table.remove(obstacles, i)
            end
        
            if obstacle.sprite.x + obstacle.width / 2 < camera.borderLeft then
                obstacle:delete()
                table.remove(obstacles, i)
            end
        end
        
        mowgli:update()
        tiger:update()


        -- ray cast to make tiger jump
        x1 = tiger.sprite.x
        y1 = tiger.sprite.y
        local groundDetector = physics.rayCast( x1, y1, x1 + 80, y1 + 25 , "closest" )
        local woodDetector = physics.rayCast( x1, y1, x1 + 150, y1, "closest")

        if groundDetector == nil or (woodDetector ~= nil and woodDetector[1].object._collision.name == "wood") then
            tiger:jump(200)
        end

        if mowgli.sprite.x > camera.borderRight - 400 then
            camera:moveForward()
        end
    else
        audio.stop()
        timer.cancel(timerID)
        timer.cancel(woodObstacleTimerId)
        composer.gotoScene( "scenes.end", {
            effect = "fade",
            params = {
                totalTime = time
            }
        })
    end
end

-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

        bg.x = display.contentCenterX
        bg.y = display.contentCenterY

        camera.x = 0
        camera.y = 0
        camera.speed = 3.2

        jumpButton.x = display.contentWidth - 60
        jumpButton.y = display.contentHeight - 40
        jumpButton:registerBeforeTouchHandler(function()
            mowgli:jump(150)
        end)

        ground:setBlock(GroundBlock, 'assets/ground/ground_64x64.png', 64, 64)

        mowgli.x = display.contentCenterX
        mowgli.y = display.contentHeight - 16
        mowgli.onCollision = function(self, event)
            if event.other._collision.name == "ground" or event.other._collision.name == "wood"  then
                self.canJump = true
                self:run("right", 3.2)
            end
    
            if event.other._collision.name == "tiger" then
                self.pv = 0
            end
        end

        tiger.x = display.contentCenterX / 2
        tiger.y = display.contentHeight - 16
        tiger.onCollision = function(self, event)
            if event.other._collision.name == "ground" or event.other._collision.name == "wood"  then
                self.canJump = true
                self:run("right", 3.2)
            end
        end

        time = 0


    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        physics:start()
        physics.setDrawMode( "hybrid" )

        audio.play( bgMusic, { loops = -1 } )
        
        bg:init()
        camera:init()
        jumpButton:init()
        ground:init()
        mowgli:init()
        camera:add(mowgli.sprite)
        tiger:init()
        camera:add(tiger.sprite)

        timeText = display.newText( time, display.contentCenterX, 25, "assets/fonts/Windlass.ttf", 18 )
        

        -- update time and text each second
        timerID = timer.performWithDelay(1000, function()
            time = time + 1

            -- format seconds to minutes
            if (time > 60) then
                _time = tostring(math.floor(time / 60)) .. ":" .. tostring(math.ceil(time % 60))
            else
                _time = time
            end

            timeText.text = _time
        end, -1)

        obstacles = {}
        woodObstacleTimerId = timer.performWithDelay(7000, function()
            local wood = WoodObstacle:new("assets/obstacles/wood.png", 35, 35)
            wood.x = camera.borderRight + 20
            wood.y = display.contentHeight - 20
            wood:init()
            wood:roll("left", 2)
            camera:add(wood.sprite)
            table.insert(obstacles, wood)
        end, -1)
        
        Runtime:addEventListener("enterFrame", self)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        Runtime:removeEventListener("enterFrame", self)

        mowgli:delete()
        tiger:delete()
        ground:delete()

        
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        
        jumpButton:delete()
        camera:delete()
        timeText:removeSelf()
        timeText = nil
        bg:delete()
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene