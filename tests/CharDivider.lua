local exports = {}

local string = require('string')
local charset = require('../charset')
local utf8 = charset.utf8
local CharDivider = charset.CharDivider

exports['CharDivider'] = function (test)
  local chars = {'a', 'b', 'c', '\194\162', 'd', 'e'}
  local divider = CharDivider:new(utf8)
  local i = 1
  divider:on('char', function(char)
    test.equal(char, chars[i])
    i = i + 1
  end)
  divider:feed('abc\194')
  divider:feed('\162de')
  test.done()
end

return exports
