--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:d5862dc422e3b26b1ae98272c7816ae8:1f6cc65407b4bf7549f5de71cdcd0732:bbda74bb1e1b22655d12e3cd3f8a27a3$
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
            -- tigre_1
            x=293,
            y=1,
            width=120,
            height=44,

        },
        {
            -- tigre_2
            x=1,
            y=1,
            width=131,
            height=48,

        },
        {
            -- tigre_3
            x=134,
            y=1,
            width=157,
            height=45,

        },
    },

    sheetContentWidth = 414,
    sheetContentHeight = 50
}

SheetInfo.frameIndex =
{
    ["tigre_1"] = 1,
    ["tigre_2"] = 2,
    ["tigre_3"] = 3,
}

SheetInfo.sequence = {
    ["run"] = {
        name = "run",
        frames = { 1, 2, 3, 1 }
    },
    ["jump"] = {
        name = "jump",
        frames = { 3 }
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
