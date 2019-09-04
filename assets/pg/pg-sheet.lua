--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:497ad7f5737187b4192d7a73cb0e595e:0c8e4258a19f231d71ef6beb7db6ef4c:afb3505f45e3c777cec8e9a035c60324$
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
            x=1,
            y=74,
            width=21,
            height=49,

        },
        {
            -- mowgli_sheet_12
            x=42,
            y=1,
            width=30,
            height=30,

        },
        {
            -- mowgli_sheet_13
            x=22,
            y=223,
            width=21,
            height=65,

        },
        {
            -- mowgli_sheet_14
            x=1,
            y=222,
            width=19,
            height=64,

        },
        {
            -- mowgli_sheet_15
            x=85,
            y=175,
            width=38,
            height=49,

        },
        {
            -- mowgli_sheet_16
            x=74,
            y=1,
            width=45,
            height=33,

        },
        {
            -- mowgli_sheet_19
            x=1,
            y=1,
            width=39,
            height=27,

        },
        {
            -- mowgli_sheet_20
            x=42,
            y=1,
            width=30,
            height=30,

        },
        {
            -- mowgli_sheet_145
            x=44,
            y=127,
            width=34,
            height=46,

        },
        {
            -- mowgli_sheet_146
            x=1,
            y=30,
            width=24,
            height=42,

        },
        {
            -- mowgli_sheet_147
            x=80,
            y=81,
            width=39,
            height=45,

        },
        {
            -- mowgli_sheet_148
            x=51,
            y=36,
            width=56,
            height=43,

        },
        {
            -- mowgli_sheet_149
            x=36,
            y=175,
            width=47,
            height=46,

        },
        {
            -- mowgli_sheet_150
            x=1,
            y=174,
            width=33,
            height=46,

        },
        {
            -- mowgli_sheet_151
            x=27,
            y=33,
            width=22,
            height=43,

        },
        {
            -- mowgli_sheet_152
            x=1,
            y=127,
            width=41,
            height=45,

        },
        {
            -- mowgli_sheet_153
            x=24,
            y=81,
            width=54,
            height=44,

        },
        {
            -- mowgli_sheet_154
            x=80,
            y=128,
            width=46,
            height=45,

        },
        {
            -- mowgli_sheet_331
            x=37,
            y=370,
            width=45,
            height=72,

        },
        {
            -- mowgli_sheet_332
            x=1,
            y=290,
            width=36,
            height=70,

        },
        {
            -- mowgli_sheet_333
            x=39,
            y=292,
            width=26,
            height=70,

        },
        {
            -- mowgli_sheet_334
            x=67,
            y=297,
            width=27,
            height=71,

        },
        {
            -- mowgli_sheet_335
            x=96,
            y=297,
            width=21,
            height=72,

        },
        {
            -- mowgli_sheet_336
            x=84,
            y=371,
            width=30,
            height=73,

        },
        {
            -- mowgli_sheet_337
            x=1,
            y=362,
            width=34,
            height=72,

        },
        {
            -- mowgli_sheet_338
            x=77,
            y=226,
            width=36,
            height=69,

        },
        {
            -- mowgli_sheet_339
            x=45,
            y=223,
            width=30,
            height=67,

        },
    },

    sheetContentWidth = 127,
    sheetContentHeight = 445
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
    ["mowgli_sheet_331"] = 19,
    ["mowgli_sheet_332"] = 20,
    ["mowgli_sheet_333"] = 21,
    ["mowgli_sheet_334"] = 22,
    ["mowgli_sheet_335"] = 23,
    ["mowgli_sheet_336"] = 24,
    ["mowgli_sheet_337"] = 25,
    ["mowgli_sheet_338"] = 26,
    ["mowgli_sheet_339"] = 27,
}

SheetInfo.sequence =
{
    ["idle"] = {
        name = "idle",
        frames = { 1 },
    },
    ["jump"] = {
        name = "jump",
        frames = { 1, 2, 3, 4, 5, 6, 7, 8 }
    },
    ["landing"] = {
        name = "landing",
        frames = { 1 }
    },
    ["swing"] = {
        name = "swing",
        frames = { 19, 20, 21, 22, 23, 24, 25, 26, 27 }
    },
    ["run"] = {
        name = "run",
        frames = { 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 }
    }
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

function SheetInfo:getSingleAnimation(name, time)
    local sequence = self.sequence[name]
    sequence.time = time
    return sequence;
end

function SheetInfo:getSequenceData(time)

    local sequences = {}

    for name, seq in pairs(self.sequence) do
        seq.time = time
        table.insert(sequences, seq)
    end

    return sequences
end

return SheetInfo
