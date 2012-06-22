local utf8 = require('./charset/utf8')
local sjis = require('./charset/sjis')

local string = require('string')
local Emitter = require('core').Emitter

local CharDivider = Emitter:extend()

function CharDivider:initialize(charset)
  self.charset = charset
end

function CharDivider:feed(data)
  local buf = self.buf and (self.buf .. data) or data
  local charset = self.charset
  local i = 1
  while i <= #buf do
    local charLen = charset.getSeqLen(string.byte(buf, i))
    if i + charLen >= #buf then
      self.buf = i + charLen == #buf and nil or string.sub(buf, i)
      break
    end
    self:emit('char', string.sub(buf, i, i + charLen - 1))
    i = i + charLen
  end
end

local CharsDivider = Emitter:extend()

function CharsDivider:initialize(charset)
  self.charset = charset
end

function CharsDivider:feed(data)
  local buf = self.buf and (self.buf .. data) or data
  local charset = self.charset
  local i = 1
  while i <= #buf do
    local charLen = charset.getSeqLen(string.byte(buf, i))
    if i + charLen - 1 > #buf then
      self:emit('chars', string.sub(buf, 1, i - 1))
      self.buf = i <= #buf and nil or string.sub(buf, i)
      break
    end
    i = i + charLen
  end
end

return {
  CharsDivider = CharsDivider,
  CharDivider = CharDivider,
  utf8 = utf8,
  sjis = sjis
}
