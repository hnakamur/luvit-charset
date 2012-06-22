local exports = {}

local Buffer = require('core').Buffer
local sjis = require('../charset/sjis')

exports['sjis.getSeqLen'] = function (test)
  test.equal(sjis.getSeqLen(0x00), 1)
  test.equal(sjis.getSeqLen(0x30), 1)
  test.equal(sjis.getSeqLen(0x7F), 1)
  test.equal(sjis.getSeqLen(0x80), 2)
  test.equal(sjis.getSeqLen(0xFF), 2)
  test.done()
end

return exports
