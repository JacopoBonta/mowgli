-- zizza suka
local composer = require( "composer" )
local physics = require( "physics" )
local LayeredBackground = require( "src.LayeredBackground" )
local Ground = require( "src.Ground" )
local GroundBlock = require( "src.GroundBlock" )
local Character = require( "src.Character" )
local Camera = require( "src.Camera" )
local ButtonImage = require( "src.ButtonImage" )
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
    
    bg:addLayer('assets/backgrounds/Nuvens.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/Background1.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/Background2.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/Background3.png', display.contentWidth, display.contentHeight)
    
    ground = Ground:new(camera)
    ground:setBlock(GroundBlock, 'assets/ground_64x64.png', 64, 64)
    
    mainPg = Character:new(camera)
    mainPg:setSprite("assets.pg.pg-sheet", "assets/pg/pg-sheet.png")
    
    jumpButton = ButtonImage:new()
    jumpButton:setImage("assets/buttons/up.png", 32, 32)
end

-- show()
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        -- Qui settiamo la posizione degli oggetti perchè se la scena viene ricaricata ripartirebbe da qui e non da create()
        
        camera.speed = 3
        
        bg.x = display.contentCenterX
        bg.y = display.contentCenterY
        
        
        mainPg.x = display.contentCenterX - 20
        mainPg.y = 160
        mainPg.speed = 3
        
        jumpButton.x = 60
        jumpButton.y = display.contentHeight - 40
        jumpButton:registerBeforeTouchHandler(function()
            mainPg:jump(-130)
        end)
        jumpButton:registerAfterTouchHandler(function()
            -- mainPg:stand()
        end)
        
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        -- Qui mostriamo gli oggetti e facciamo partire audio ed eventuali timer
        
        physics.start()
        physics.setDrawMode( "hybrid" )
        
        bg:init()
        ground:init()
        mainPg:init()
        jumpButton:init(sceneGroup)
        
        mainPg:run("right")
        
        Runtime:addEventListener("enterFrame", self)
    end
end

-- enterFrame() method is called once per frame
function scene:enterFrame()
    if mainPg.pv > 0 then
        ground:update()
        mainPg:update()

        if mainPg.sprite.x > camera.borderRight - 400 then
            camera:moveForward()
        end
    else
        print('game over')
        
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
        ground:delete()
        bg:delete()
        
        camera:delete()
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
