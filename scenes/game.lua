local composer = require( "composer" )
local physics = require( "physics" )
local LayeredBackground = require( "src.LayeredBackground" )
local Ground = require( "src.Ground" )
local GroundBlock = require( "src.GroundBlock" )
local Character = require( "src.Character" )
local Camera = require( "src.Camera" )
local Button = require( "src.Button" )
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
    
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    -- Qui creiamo gli oggetti che ci serviranno all'interno della scena
    
    camera = Camera:new(sceneGroup)
    
    bg = LayeredBackground:new(sceneGroup)
    
    bg:addLayer('assets/backgrounds/plx-1.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-2.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-3.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-4.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-5.png', display.contentWidth, display.contentHeight)
    
    ground = Ground:new(camera)
    ground:setBlock(GroundBlock, 'assets/ground/ground_64x64.png', 64, 64)
    
    mainPg = Character:new( "mowgli", camera)
    mainPg:setSprite("assets.pg.pg-sprites", "assets/pg/pg-sprites.png", 800)

    tiger = Character:new( "tiger ", camera)
    tiger:setSprite("assets.tiger.tiger-sheet", "assets/tiger/tiger-sheet.png", 400)
    
    jumpButton = Button:new("assets/buttons/up.png", 64, 64)
    
    bgMusic = audio.loadSound( "assets/audio/bg1.mp3" )
end

-- show()
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        -- Qui settiamo la posizione degli oggetti perchè se la scena viene ricaricata ripartirebbe da qui e non da create()
        
        camera.speed = 3.2
        
        bg.x = display.contentCenterX
        bg.y = display.contentCenterY
        
        
        mainPg.x = 200
        mainPg.y = display.contentWidth - 450
        mainPg.speed = 3.2
        mainPg.onCollision = function(self, event)
            if event.other._collision.name == "ground"  then
                self.isGround = true
                self:run("right")
            end
    
            if event.other._collision.name == "tiger" then
                self.pv = 0
            end
        end

        mainPg.onExitCollision = function(self, event)
            if event.other._collision.name == "ground" then
                self.isGround = false
            end
        end

        tiger.x = 10
        tiger.y = display.contentWidth - 450
        tiger.speed = 3.2
        tiger.onCollision = function(self, event)
            if event.other._collision.name == "ground"  then
                self.isGround = true
                self:run("right")
            end
        end
        tiger.onExitCollision = function(self, event)
            if event.other._collision.name == "ground" then
                self.isGround = false
            end
        end

        jumpButton.x = display.contentWidth - 60
        jumpButton.y = display.contentHeight - 40
        jumpButton:registerBeforeTouchHandler(function()
            mainPg:jump(-150)
        end)
        jumpButton:registerAfterTouchHandler(function()
        end)


        audio.play( bgMusic, { loops = -1 } )
        
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        -- Qui mostriamo gli oggetti e facciamo partire audio ed eventuali timer
        
        physics.start()
        -- physics.setDrawMode( "hybrid" )
        
        bg:init()
        ground:init()
        
        tiger:init()
        mainPg:init()

        jumpButton:init()

        time = 57
        timeText = display.newText( sceneGroup, time, display.contentCenterX, 20, native.systemFont, 24 )
        timerID = timer.performWithDelay(1000, function()
            time = time + 1
            if (time > 60) then
                _time = tostring(math.floor(time / 60)) .. ":" .. tostring(math.ceil(time % 60))
            else
                _time = time
            end
            timeText.text = _time
        end, -1)

        Runtime:addEventListener("enterFrame", self)
    end
end

-- enterFrame() method is called once per frame
function scene:enterFrame()
    if mainPg.pv > 0 then
        ground:update()
        mainPg:update()
        tiger:update()

        -- ray cast
        local hits = physics.rayCast( tiger.sprite.x + tiger.sprite.width / 2 + 2, tiger.sprite.y, tiger.sprite.x + tiger.sprite.width / 2 + 40, tiger.sprite.y + tiger.sprite.height, "closest" )


        if (hits == nil and tiger.isGround == true) then
            tiger:jump(-200)
        end

        
        if mainPg.sprite.x > camera.borderRight - 400 then
            camera:moveForward()
        end
    else
        print('game over')

        audio.stop()
        
        composer.gotoScene( "scenes.end", {
            effect = "fade"
        })
    end
end


-- hide()
function scene:hide( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        -- Qui stoppiamo fisica, audio ed eventuali timer
        print('hide')
        Runtime:removeEventListener("enterFrame", self)
        
        physics.stop()
        
        jumpButton:delete()
        
        mainPg:delete()
        tiger:delete()
        ground:delete()
        bg:delete()
        
        camera:delete()

        timer.cancel(timerID)

        audio.dispose( bgMusic )
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        
    end
end


-- destroy()
function scene:destroy( event )
    
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    -- Qui facciamo il dispose dell'audio e rimuoviamo i listener per tutti gli oggetti che non sono dentro a sceneGroup (se un displayObject viene inserito all'interno dello sceneGroup corona si occupa di rimuoverlo per noi - listeners compresi) 
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
