local exports = {}

local string = require('string')
local Buffer = require('buffer').Buffer
local utf8 = require('../charset/utf8')

exports['utf8.getSeqLen'] = function (test)
  test.equal(utf8.getSeqLen(0x00), 1)
  test.equal(utf8.getSeqLen(0x30), 1)
  test.equal(utf8.getSeqLen(0x7F), 1)
  test.equal(utf8.getSeqLen(0xC2), 2)
  test.equal(utf8.getSeqLen(0xDF), 2)
  test.equal(utf8.getSeqLen(0xE0), 3)
  test.equal(utf8.getSeqLen(0xEF), 3)
  test.equal(utf8.getSeqLen(0xF0), 4)
  test.equal(utf8.getSeqLen(0xF7), 4)
  test.equal(utf8.getSeqLen(0xF8), 5)
  test.equal(utf8.getSeqLen(0xFB), 5)
  test.equal(utf8.getSeqLen(0xFC), 6)
  test.equal(utf8.getSeqLen(0xFD), 6)
  test.equal(utf8.getSeqLen(0xFE), nil)
  test.equal(utf8.getSeqLen(0xFF), nil)
  test.done()
end

exports['utf8 buffer1'] = function (test)
  local buf = Buffer:new('\194\162abcdef')
  local count = 3
  local pos = 1
  local i = 1
  while i < count do
    local b = buf:readUInt8(pos)
    pos = pos + utf8.getSeqLen(b)
    i = i + 1
  end
  test.equal(pos, 4)
  test.equal(string.sub(tostring(buf), 1, pos), '\194\162ab')
  test.done()
end

return exports
