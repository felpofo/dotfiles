#!/bin/fish

set file /opt/discord/resources/build_info.json
set v (jq '.version | split(".")[2] | tonumber' < $file)

sed -ie "s/$v/"(math $v + 1)"/" $file
