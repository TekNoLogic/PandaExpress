
local myname, ns = ...


function ns.ColorNum(num)
  local color = (num > 0) and HIGHLIGHT_FONT_COLOR_CODE or GRAY_FONT_COLOR_CODE
  return color.. num.. "|r"
end
