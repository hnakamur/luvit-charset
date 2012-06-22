# luvit-charset

With this module, you can divide binary data to chracters or charater blocks.

one character at time
```
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
```

character blocks
```
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
```
