#!/usr/bin/fish

################################################################

set overwrite false
set purge false
set unlink false

################################################################

set i 0
while true
  set i (math $i + 1)
  if test $i -gt (count $argv); break; end

  switch $argv[$i]
    case -o --overwrite; set overwrite true
    case -p --purge;  set purge true
    case -u --unlink; set unlink true
    case --; break
  end
end
set -e i

if $purge
or $unlink
  set overwrite true
end

################################################################

function delete -a file color
  if test (count $argv) -eq 1
    set color 31
  end

  if not $overwrite
    backup $file
  end

  echo -e "Removing '\x1b["$color"m$file\x1b[m'"
  rm -f $file
end

function backup -a file
  echo -e "Backing up '\x1b[33m$file\x1b[m' -> '\x1b[32m$file.old\x1b[m'"
  mv $file $file.old
end

function confirm
  while true
    read -lP "Continue? [Y/n] " confirm

    switch $confirm
      case '' Y y
        return (eval true)
      case N n
        return (eval false)
    end
  end
end

################################################################

function link -a source destination
  if not test -L $destination
    if test -f $destination
      delete $destination
    end
  end

  mkdir -p (path dirname $destination)

  echo -e "Linking '\x1b[36m$source\x1b[m' -> '\x1b[34m$destination\x1b[m'"
  ln -sf $source $destination
end

################################################################

if $unlink
  echo -e "\x1b[33;1mWarning\x1b[m: will remove all \x1b[34;1mlinks\x1b[m"
  if not confirm
    return
  end

  function link -a _ destination
    if test -L $destination
      delete $destination 34
    end
  end
end

if $purge
  echo -e "\x1b[33;1mWarning\x1b[m: will remove all \x1b[34;1mlink\x1b[m and \x1b[31;1mbackup\x1b[m files"
  if not confirm
    return
  end

  function link -a _ destination
    if test -L $destination
      delete $destination 34
    end

    if test -f $destination.old
      delete $destination.old
    end
  end
end

################################################################

link (pwd)/.fishrc ~/.config/fish/config.fish
link (pwd)/.tmuxrc ~/.tmux.conf
link (pwd)/.sxhkdrc ~/.config/sxhkd/sxhkdrc
link (pwd)/.alacrittyrc ~/.config/alacritty.toml
link (pwd)/.alacrittytheme ~/.config/alacritty.theme.toml
link (pwd)/.alacrittykeys ~/.config/alacritty.keybinds.toml
