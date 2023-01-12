#!/bin/bash

make_desktop(){
    app=$1
cat > ${app}-nativefier.desktop <<EOF
[Desktop Entry]
Name=$app
Comment=$app for desktop built with nativefier (electron)
Exec=$app-nativefier
Icon=$app-nativefier
Encoding=UTF-8
StartupWMClass=$app-nativefier
Terminal=false
StartupNotify=true
Type=Application
Categories=Application;
EOF
}

_app_list=(
    "keep"
    "meet"
    "calendar"
    "reddit"
    "ai-core"
    "chatgpt"
)


for app in "${_app_list[@]}"; do
    make_desktop $app 
done
