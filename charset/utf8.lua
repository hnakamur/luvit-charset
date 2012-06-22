function getSeqLen(leadByte)
  if leadByte <= 0x7F then
    return 1
  elseif leadByte <= 0xDF then
    return 2
  elseif leadByte <= 0xEF then
    return 3
  elseif leadByte <= 0xF7 then
    return 4
  elseif leadByte <= 0xFB then
    return 5
  elseif leadByte <= 0xFD then
    return 6
  else
    return nil
  end
end

return {
  getSeqLen = getSeqLen
}
