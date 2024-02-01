#!/usr/bin/fish

set overwrite false

set i 1
while true
  if test $i -gt (count $argv); break; end

  switch $argv[$i]
    case '-o' or '--overwrite'
      set overwrite true
    case '--'
      break
  end

  set i (math $i + 1)
end
set -e i

function link -a source destination
  if test -L "$destination"
    echo -e "Ignoring '\x1b[36m$source\x1b[m' because '\x1b[34m$destination\x1b[m' already exists"
    return
  end

  if test -f "$destination"
    if $overwrite
      echo -e "Removing '\x1b[31m$destination\x1b[m'"
      rm -f "$destination"
    else
      echo -e "Moving '\x1b[33m$destination\x1b[m' -> '\x1b[32m$destination.old\x1b[m'"
      mv "$destination" "$destination.old"
    end
  end

  echo -e "Done '\x1b[36m$source\x1b[m'"
  ln -s "$source" "$destination"
end

link .fishrc ~/.config/fish/config.fish
