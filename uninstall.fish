#!/bin/fish

function restore -a source destination
  if test -L "$destination"
    if not test -e "$destination.old"
      echo -e "\e[31mDeleted\e[m '"(path basename $destination)"'"
    end
    rm -f "$destination"
  end

  if test -e "$destination.old"
    mv "$destination.old" "$destination"
    echo -e "\e[35mRestored\e[0m '"(path basename $destination)"'"
  end
end

alias do restore
. files.fish
