#!/bin/fish

set blue "#8aadf4"
set pink "#f5bde6"
set purple "#c6a0f6"
set green "#a6da95"
set red "#ed8796"

function update_focused
  set focused (bspc query -n -T)

  if (eval (echo $focused | jq '.private')) set private; end
  if (eval (echo $focused | jq '.locked'))  set locked; end
  if (eval (echo $focused | jq '.sticky'))  set sticky; end
  if (eval (echo $focused | jq '.marked'))  set marked; end

  set color $blue

  if set -q $private; set color $pink; end
  if set -q $locked; set color $purple; end
  if set -q $sticky; set color $green; end
  if set -q $marked; set color $red; end

  bspc config focused_border_color "$color"
end

update_focused

bspc subscribe node_focus node_flag | while read -r _
  update_focused
end &> /dev/null
