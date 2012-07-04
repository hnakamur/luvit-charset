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
    if i + charLen - 1 <= #buf then
      self:emit('char', string.sub(buf, i, i + charLen - 1))
      i = i + charLen
      if i > #buf then
        self.buf = nil
        break
      end
    else
      self.buf = string.sub(buf, i)
      break
    end
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
    if i + charLen - 1 <= #buf then
      i = i + charLen
      if i > #buf then
        self:emit('chars', buf)
        self.buf = nil
        break
      end
    else
      self:emit('chars', string.sub(buf, 1, i - 1))
      self.buf = string.sub(buf, i)
      break
    end
  end
end

return {
  CharsDivider = CharsDivider,
  CharDivider = CharDivider,
  utf8 = utf8,
  sjis = sjis
}
