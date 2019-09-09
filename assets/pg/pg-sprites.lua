--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:387383dc2e31474f25a3c4d438cb3929:abd8644168f95cc4f0c4b094b552fc2f:a9f8d409fe5ee0e0e600cb59bd14b0b1$
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
            -- mowgli_sheet_11
            x=36,
            y=444,
            width=21,
            height=49,

        },
        {
            -- mowgli_sheet_12
            x=1,
            y=492,
            width=30,
            height=30,

        },
        {
            -- mowgli_sheet_13
            x=42,
            y=288,
            width=21,
            height=65,

        },
        {
            -- mowgli_sheet_14
            x=44,
            y=222,
            width=19,
            height=64,

        },
        {
            -- mowgli_sheet_15
            x=1,
            y=345,
            width=38,
            height=49,

        },
        {
            -- mowgli_sheet_16
            x=1,
            y=187,
            width=45,
            height=33,

        },
        {
            -- mowgli_sheet_19
            x=1,
            y=316,
            width=39,
            height=27,

        },
        {
            -- mowgli_sheet_20
            x=1,
            y=492,
            width=30,
            height=30,

        },
        {
            -- mowgli_sheet_145
            x=1,
            y=396,
            width=34,
            height=46,

        },
        {
            -- mowgli_sheet_146
            x=37,
            y=400,
            width=24,
            height=42,

        },
        {
            -- mowgli_sheet_147
            x=1,
            y=269,
            width=39,
            height=45,

        },
        {
            -- mowgli_sheet_148
            x=1,
            y=1,
            width=56,
            height=43,

        },
        {
            -- mowgli_sheet_149
            x=1,
            y=92,
            width=47,
            height=46,

        },
        {
            -- mowgli_sheet_150
            x=1,
            y=444,
            width=33,
            height=46,

        },
        {
            -- mowgli_sheet_151
            x=41,
            y=355,
            width=22,
            height=43,

        },
        {
            -- mowgli_sheet_152
            x=1,
            y=222,
            width=41,
            height=45,

        },
        {
            -- mowgli_sheet_153
            x=1,
            y=46,
            width=54,
            height=44,

        },
        {
            -- mowgli_sheet_154
            x=1,
            y=140,
            width=46,
            height=45,

        },
    },

    sheetContentWidth = 64,
    sheetContentHeight = 523
}

SheetInfo.frameIndex =
{

    ["mowgli_sheet_11"] = 1,
    ["mowgli_sheet_12"] = 2,
    ["mowgli_sheet_13"] = 3,
    ["mowgli_sheet_14"] = 4,
    ["mowgli_sheet_15"] = 5,
    ["mowgli_sheet_16"] = 6,
    ["mowgli_sheet_19"] = 7,
    ["mowgli_sheet_20"] = 8,
    ["mowgli_sheet_145"] = 9,
    ["mowgli_sheet_146"] = 10,
    ["mowgli_sheet_147"] = 11,
    ["mowgli_sheet_148"] = 12,
    ["mowgli_sheet_149"] = 13,
    ["mowgli_sheet_150"] = 14,
    ["mowgli_sheet_151"] = 15,
    ["mowgli_sheet_152"] = 16,
    ["mowgli_sheet_153"] = 17,
    ["mowgli_sheet_154"] = 18,
}

SheetInfo.sequence =
{
    ["idle"] = {
        name = "idle",
        frames = { 1 },
    },
    ["jump"] = {
        name = "jump",
        frames = { 12 },
        loopCount = 1
    },
    ["run"] = {
        name = "run",
        frames = { 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 }
    }
}

function SheetInfo:getSequenceData(time)

    local sequences = {}

    for name, seq in pairs(self.sequence) do
        seq.time = time
        table.insert(sequences, seq)
    end

    return sequences
end

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
