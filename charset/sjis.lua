function getSeqLen(leadByte)
  if leadByte <= 0x7F then
    return 1
  else
    return 2
  end
end

return {
  getSeqLen = getSeqLen
}
