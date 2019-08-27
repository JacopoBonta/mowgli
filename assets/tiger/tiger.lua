--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:15f0f2c68c924d3ac231936eb23a1dbd:7b6b50fb9729d8999e500a628685cfd0:9b01d355d8b67016694adf85b8fcea5e$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- tile000
            x=1,
            y=381,
            width=256,
            height=118,

            sourceX = 12,
            sourceY = 18,
            sourceWidth = 282,
            sourceHeight = 152
        },
        {
            -- tile001
            x=263,
            y=131,
            width=246,
            height=126,

            sourceX = 13,
            sourceY = 14,
            sourceWidth = 282,
            sourceHeight = 152
        },
        {
            -- tile002
            x=259,
            y=387,
            width=246,
            height=126,

            sourceX = 13,
            sourceY = 16,
            sourceWidth = 282,
            sourceHeight = 152
        },
        {
            -- tile003
            x=1,
            y=501,
            width=228,
            height=122,

            sourceX = 17,
            sourceY = 13,
            sourceWidth = 282,
            sourceHeight = 152
        },
        {
            -- tile004
            x=265,
            y=1,
            width=240,
            height=128,

            sourceX = 16,
            sourceY = 10,
            sourceWidth = 282,
            sourceHeight = 152
        },
        {
            -- tile005
            x=1,
            y=249,
            width=256,
            height=130,

            sourceX = 12,
            sourceY = 10,
            sourceWidth = 282,
            sourceHeight = 152
        },
        {
            -- tile006
            x=259,
            y=259,
            width=248,
            height=126,

            sourceX = 12,
            sourceY = 12,
            sourceWidth = 282,
            sourceHeight = 152
        },
        {
            -- tile007
            x=1,
            y=125,
            width=260,
            height=122,

            sourceX = 6,
            sourceY = 10,
            sourceWidth = 282,
            sourceHeight = 152
        },
        {
            -- tile008
            x=1,
            y=1,
            width=262,
            height=122,

            sourceX = 13,
            sourceY = 8,
            sourceWidth = 282,
            sourceHeight = 152
        },
    },

    sheetContentWidth = 510,
    sheetContentHeight = 624
}

SheetInfo.frameIndex =
{

    ["tile000"] = 1,
    ["tile001"] = 2,
    ["tile002"] = 3,
    ["tile003"] = 4,
    ["tile004"] = 5,
    ["tile005"] = 6,
    ["tile006"] = 7,
    ["tile007"] = 8,
    ["tile008"] = 9,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
