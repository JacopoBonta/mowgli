--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:e77831c6742fbe35ae1c71588d74bf4c:b6242d2ccaf387cbe108d91f515109df:ac1b5630a6e92804dff1c4f3ce3fde82$
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
            -- idle-0
            x=23,
            y=33,
            width=21,
            height=36,

        },
        {
            -- idle-1
            x=0,
            y=35,
            width=21,
            height=36,

        },
        {
            -- idle-2
            x=21,
            y=69,
            width=21,
            height=36,

        },
        {
            -- idle-3
            x=42,
            y=100,
            width=21,
            height=36,

        },
        {
            -- idle-4
            x=0,
            y=71,
            width=21,
            height=36,

        },
        {
            -- idle-5
            x=21,
            y=105,
            width=21,
            height=36,

        },
        {
            -- idle-6
            x=42,
            y=136,
            width=21,
            height=36,

        },
        {
            -- idle-7
            x=0,
            y=107,
            width=21,
            height=36,

        },
        {
            -- idle-8
            x=21,
            y=141,
            width=21,
            height=36,

        },
        {
            -- idle-9
            x=21,
            y=177,
            width=21,
            height=34,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 21,
            sourceHeight = 36
        },
        {
            -- idle-10
            x=0,
            y=143,
            width=21,
            height=34,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 21,
            sourceHeight = 36
        },
        {
            -- idle-11
            x=0,
            y=177,
            width=21,
            height=34,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 21,
            sourceHeight = 36
        },
        {
            -- jump
            x=46,
            y=0,
            width=17,
            height=34,

        },
        {
            -- landing
            x=0,
            y=282,
            width=20,
            height=35,

        },
        {
            -- ledge-grab-0
            x=0,
            y=244,
            width=20,
            height=38,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 20,
            sourceHeight = 40
        },
        {
            -- ledge-grab-1
            x=42,
            y=240,
            width=20,
            height=40,

        },
        {
            -- ledge-grab-2
            x=20,
            y=244,
            width=20,
            height=38,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 20,
            sourceHeight = 40
        },
        {
            -- ledge-grab-3
            x=40,
            y=280,
            width=20,
            height=38,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 20,
            sourceHeight = 40
        },
        {
            -- ledge-grab-4
            x=0,
            y=318,
            width=20,
            height=38,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 20,
            sourceHeight = 40
        },
        {
            -- ledge-grab-5
            x=20,
            y=318,
            width=20,
            height=38,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 20,
            sourceHeight = 40
        },
        {
            -- mid-air-0
            x=20,
            y=282,
            width=20,
            height=35,

        },
        {
            -- mid-air-1
            x=40,
            y=318,
            width=20,
            height=35,

        },
        {
            -- run-0
            x=0,
            y=0,
            width=23,
            height=35,

        },
        {
            -- run-1
            x=42,
            y=207,
            width=21,
            height=33,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 23,
            sourceHeight = 35
        },
        {
            -- run-2
            x=44,
            y=67,
            width=17,
            height=33,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 23,
            sourceHeight = 35
        },
        {
            -- run-3
            x=0,
            y=211,
            width=21,
            height=33,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 23,
            sourceHeight = 35
        },
        {
            -- run-4
            x=42,
            y=172,
            width=21,
            height=35,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 23,
            sourceHeight = 35
        },
        {
            -- run-5
            x=44,
            y=34,
            width=19,
            height=33,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 23,
            sourceHeight = 35
        },
        {
            -- run-6
            x=21,
            y=211,
            width=21,
            height=33,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 23,
            sourceHeight = 35
        },
        {
            -- run-7
            x=23,
            y=0,
            width=23,
            height=33,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 23,
            sourceHeight = 35
        },
    },

    sheetContentWidth = 63,
    sheetContentHeight = 356
}

SheetInfo.frameIndex =
{

    ["idle-0"] = 1,
    ["idle-1"] = 2,
    ["idle-2"] = 3,
    ["idle-3"] = 4,
    ["idle-4"] = 5,
    ["idle-5"] = 6,
    ["idle-6"] = 7,
    ["idle-7"] = 8,
    ["idle-8"] = 9,
    ["idle-9"] = 10,
    ["idle-10"] = 11,
    ["idle-11"] = 12,
    ["jump"] = 13,
    ["landing"] = 14,
    ["ledge-grab-0"] = 15,
    ["ledge-grab-1"] = 16,
    ["ledge-grab-2"] = 17,
    ["ledge-grab-3"] = 18,
    ["ledge-grab-4"] = 19,
    ["ledge-grab-5"] = 20,
    ["mid-air-0"] = 21,
    ["mid-air-1"] = 22,
    ["run-0"] = 23,
    ["run-1"] = 24,
    ["run-2"] = 25,
    ["run-3"] = 26,
    ["run-4"] = 27,
    ["run-5"] = 28,
    ["run-6"] = 29,
    ["run-7"] = 30,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
