#!/bin/fish

set pictures ~/Pictures/Screenshots

set now (date '+%Y-%m-%d_%H%M')
set id (tr -dc a-f0-9 < /dev/random | head -c 8)
set image $pictures/Screenshot_$now.$id.png

set save false
set full false

set i 0
while true
  set i (math $i + 1)
  if test $i -gt (count $argv); break; end

  switch $argv[$i]
    case -f --full
      set full true
    case -s --save
      set save true
    case --
      break
  end
end
set -e i

set command 'maim' '-o' '-b' '4' '-c' '0.96,0.74,0.9'

if not $full
  set -a command '--select'
end

set old (bspc config border_width)
bspc config border_width 0
if $save
  $command $image
else
  $command | xclip -selection clipboard -target image/png
end
bspc config border_width $old

if test $status -eq 0
  if $save
    echo "$image"
    notify-send 'Screenshot' "Saved to '$image'"
  else
    notify-send 'Screenshot' 'Copied to clipboard!'
  end
else
  notify-send 'Screenshot' 'Aborted'
end
