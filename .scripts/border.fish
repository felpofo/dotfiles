#!/bin/fish

set blue "#8aadf4"
set pink "#f5bde6"
set purple "#c6a0f6"
set green "#a6da95"
set red "#ed8796"

function update_focused
  set focused (bspc query -n -T)

  set private (echo $focused | jq '.private')
  set locked (echo $focused | jq '.locked')
  set sticky (echo $focused | jq '.sticky')
  set marked (echo $focused | jq '.marked')

  set color $blue

  if $private; set color $pink; end
  if $locked; set color $purple; end
  if $sticky; set color $green; end
  if $marked; set color $red; end

  bspc config focused_border_color "$color"
end

update_focused

bspc subscribe node_focus node_flag | while read -r _
  update_focused
end &> /dev/null
