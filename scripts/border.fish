#!/bin/fish

set blue "#8aadf4"
set pink "#f5bde6"
set purple "#c6a0f6"
set green "#a6da95"
set red "#ed8796"

function update_focused
  set focused (bspc query -n -T)

  set private (echo $focused | jq -r '.private')
  set locked (echo $locked | jq -r '.locked')
  set sticky (echo $sticky | jq -r '.sticky')
  set marked (echo $marked | jq -r '.marked')

  set color $blue

  if set -q $private; and $private; set color $pink; end
  if set -q $locked; and $locked; set color $purple; end
  if set -q $sticky; and $sticky; set color $green; end
  if set -q $marked; and $marked; set color $red; end

  bspc config focused_border_color "$color"
end

update_focused

bspc subscribe node_focus node_flag | while read -r _
  update_focused
end &> /dev/null
