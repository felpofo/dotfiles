#!/bin/fish

set overwrite false

set i 0
while true
  set i (math $i + 1)
  if test $i -gt (count $argv); break; end

  switch $argv[$i]
    case -o --overwrite; set overwrite true
    case --; break
  end
end
set -e i

function link -a source destination
  if test -L $destination
    rm -f "$destination"
  end

  if test -e $destination
    if not $overwrite
      mv "$destination" "$destination.old"
      echo -e "\e[33mSaved\e[m '$destination'"
    else
      rm -f "$destination"
      echo -e "\e[31mDeleted\e[m '$destination'"
    end
  end

  mkdir -p (path dirname $destination)
  ln -s "$source" "$destination"
  echo -e "\e[36mInstalled\e[m '"(path basename $source)"'"
end

alias do link
. files.fish

