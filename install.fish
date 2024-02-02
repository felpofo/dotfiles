#!/usr/bin/fish

set overwrite false
set clean false
set unlink false

set i 0
while true
  set i (math $i + 1)
  if test $i -gt (count $argv); break; end

  switch $argv[$i]
    case -o --overwrite
      set overwrite true
    case -c --clean
      set clean true
    case -u --unlink
      set unlink true
    case --
      break
  end
end
set -e i


function delete -a file
  if test -e $file
    echo -e "Removing '\x1b[31m$file\x1b[m'"
    rm -f $file
  end
end

function backup -a file
  echo -e "Backing up '\x1b[33m$file\x1b[m' -> '\x1b[32m$file.old\x1b[m'"
  mv $file $file.old
end


function link -a source destination
  if test -L $destination
    echo -e "Ignoring '\x1b[36m$source\x1b[m' because '\x1b[34m$destination\x1b[m' already exists"
    return
  end

  if test -f $destination
    if $overwrite
      delete $destination
    else
      backup $destination
    end
  end

  mkdir -p (path dirname $destination)

  echo -e "Linked '\x1b[36m$source\x1b[m' -> '\x1b[34m$destination\x1b[m'"
  ln -s $source $destination
end

function unlink -a destination
  if not test -L $destination
    echo -e "Ignoring non-symlink '\x1b[34m$destination\x1b[m'"
    return
  end

  delete $destination
end

alias do link
if $unlink; function do -a src dst; unlink $dst; end; end
if $clean; function do -a src dst; delete $dst.old; end; end

do .fishrc ~/.config/fish/config.fish
do .tmuxrc ~/.tmux.conf
