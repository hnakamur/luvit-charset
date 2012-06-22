local exports = {}

local string = require('string')
local charset = require('../charset')
local utf8 = charset.utf8
local CharsDivider = charset.CharsDivider

exports['CharsDivider'] = function (test)
  local chars = {'abc', '\194\162de'}
  local divider = CharsDivider:new(utf8)
  local i = 1
  divider:on('chars', function(char)
    test.equal(char, chars[i])
    i = i + 1
  end)
  divider:feed('abc\194')
  divider:feed('\162de')
  test.done()
end

return exports
