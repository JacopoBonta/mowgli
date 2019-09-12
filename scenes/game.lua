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

-- Scena di gioco. In questa scena viene gestita la logica del gioco, la creazione degli oggetti e di come questi interagiscono tra di loro

local bg, camera, ground, mowgli, tiger, time, timeText, timerID, bgMusic, obstacles

-- create() viene chiamata una sola volta. Qui vengono creati gli oggetti che saranno utilizzati nel gioco
function scene:create( event )
 
    local sceneGroup = self.view

    bg = Background:new(sceneGroup)
    -- il background è formato da più strati. Attenzione all'ordinamento.
    bg:addLayer('assets/backgrounds/plx-1.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-2.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-3.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-4.png', display.contentWidth, display.contentHeight)
    bg:addLayer('assets/backgrounds/plx-5.png', display.contentWidth, display.contentHeight)

    -- gli oggetti aggiunti alla camera devono essere inseriti anche nello sceneGroup che si occupa di gestire tutti i display objects che fanno parte della scena corrente
    camera = Camera:new(sceneGroup)
    ground = Ground:new(camera)
    jumpButton = Button:new("assets/buttons/up.png", 64, 64)
    mowgli = Character:new( "mowgli", "assets.pg.pg-sprites", "assets/pg/pg-sprites.png", 800)
    tiger = Character:new( "tiger", "assets.tiger.tiger-sheet", "assets/tiger/tiger-sheet.png", 400)
    bgMusic = audio.loadSound( "assets/audio/bg.mp3" )
end

-- enterFrame() viene chiamato ad ogni frame. Aggiorna le posizioni degli oggetti, gestisce i raycast e termina il gioco se mowgli ha perso tutti i punti vita
function scene:enterFrame()

    if mowgli.pv > 0 then

        -- elimina gli ostacoli fuori dallo schermo
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

        ground:update()
        mowgli:update()
        tiger:update()

        -- ray cast per far saltare la tigre
        x1 = tiger.sprite.x
        y1 = tiger.sprite.y
        local groundDetector = physics.rayCast( x1, y1, x1 + 80, y1 + 25 , "closest" )
        local woodDetector = physics.rayCast( x1, y1, x1 + 150, y1, "closest")
        if groundDetector == nil or (woodDetector ~= nil and woodDetector[1].object._collision.name == "wood") then
            tiger:jump(200)
        end

        -- sposta la telecamera
        if mowgli.sprite.x > camera.borderRight - 400 then
            camera:moveForward()
        end
    else
        -- mowgli è morto ed il gioco è terminato, cancella i timer e cambia scena
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

        -- Non appena la scena sta per comparire resettiamo i valori degli oggetti di gioco alla loro posizione iniziale

        bg.x = display.contentCenterX
        bg.y = display.contentCenterY

        camera.x = 0
        camera.y = 0
        camera.speed = 3.2

        jumpButton.x = display.contentWidth - 60
        jumpButton.y = display.contentHeight - 40
        jumpButton.beforeCb = function()
            mowgli:jump(150)
        end

        -- qui definiamo che tipo di blocco utilizzare per il terreno
        ground:setBlock(GroundBlock, 'assets/ground/ground_64x64.png', 64, 64)

        mowgli.x = display.contentCenterX
        mowgli.y = display.contentHeight - 16
        mowgli.onCollision = function(self, event)
            if event.other._collision.name == "ground" or event.other._collision.name == "wood"  then
                self.canJump = true
                self:run("right", 3.2)
            end
    
            if event.other._collision.name == "tiger" then
                audio.play( roar, { onComplete=function(event)
                    if event.completed then
                        audio.stop()
                    end
                end} )
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
        obstacles = {}

    elseif ( phase == "did" ) then
        
        -- La scena è diventata visibile, avviamo la fisica ed inizializziamo gli oggetti
        physics:start()
        -- physics.setDrawMode( "hybrid" )

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

        -- timer per aggiornare il tempo e la scritta
        timerID = timer.performWithDelay(1000, function()
            time = time + 1

            -- formatta i secondi in minuti
            if (time > 60) then
                _time = tostring(math.floor(time / 60)) .. ":" .. tostring(math.ceil(time % 60))
            else
                _time = time
            end

            timeText.text = _time
        end, -1)

        -- timer per generare gli ostacoli
        woodObstacleTimerId = timer.performWithDelay(7000, function()

            -- possono essere generati da 1 a 3 ostacoli ogni 7 secondi
            local rand = math.random(1, 3)
            local offset = 0
            for i = 1, rand, 1 do
                local wood = WoodObstacle:new("assets/obstacles/wood.png", 35, 35)
                wood.x = camera.borderRight + 20 + offset
                wood.y = display.contentHeight - 20
                wood:init()
                wood:roll("left", 2)
                camera:add(wood.sprite)
                table.insert(obstacles, wood)
                offset = offset + wood.width + 3
            end
        end, -1)
        
        -- registra il metodo enterFrame per essere chiamato ad ogni frame
        Runtime:addEventListener("enterFrame", self)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Qui la scena sta per uscire dallo schermo quindi eliminamo gli oggetti e cancelliamo il listener
        Runtime:removeEventListener("enterFrame", self)

        timeText:removeSelf()
        timeText = nil
        jumpButton:delete()
        
        bg:delete()
        camera:delete()

        mowgli:delete()
        tiger:delete()
        ground:delete()

    elseif ( phase == "did" ) then

    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    audio.dispose( bgMusic )
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