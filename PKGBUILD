pkgname=illef-nativefier-apps
pkgver=20221012
pkgrel=1
pkgdesc="illef apps built with nativefier (electron)"
arch=("i686" "x86_64")
license=("custom")
depends=()
optdepends=()
makedepends=("unzip" "jq" "yarn")
source=(
    "keep-nativefier.desktop"
    "calendar-nativefier.desktop"
    "reddit-nativefier.desktop"
    "ai-core-nativefier.desktop"
    "chatgpt-nativefier.desktop"
    "keep.png"
    "calendar.png"
    "reddit.png"
    "chatgpt.png"
    "feedly.png"
    "feedly-nativefier.desktop"
    "https://github.com/elibroftw/google-keep-desktop-app/archive/refs/tags/v1.0.18.zip"
)
_app_list=(
    "keep;https:\/\/keep.google.com"
    "calendar;https:\/\/calendar.google.com"
    "reddit;https:\/\/www.reddit.com"
    "chatgpt;https:\/\/chat.openai.com\/chat"
    "feedly;https:\/\/feedly.com"
)


_build() {
    app_name=$(echo "$1" | cut -d";" -f1)
    url=$(echo "$1" | cut -d";" -f2)
    tauri_dir="${srcdir}/google-keep-desktop-app-1.0.18"

    cp ${app_name}.png $tauri_dir
    echo "s/'.*'/'${url}'/" "$tauri_dir/src-tauri/src/main.rs"
    sed -i "s/'.*'/'${url}'/" "$tauri_dir/src-tauri/src/main.rs"
    ( 
        cd ${tauri_dir} && yarn tauri icon ${app_name}.png && yarn tauri build --bundles none
    )
    cp ${tauri_dir}/src-tauri/target/release/google-keep ${srcdir}/${app_name}-nativefier

}

build() {

    ( cd ${srcdir}/google-keep-desktop-app-1.0.18/ && yarn )
    for app in "${_app_list[@]}"; do
        _build $app 
    done
}

_package() {
    app_name=$(echo "$1" | cut -d";" -f1)

    mkdir -p "${pkgdir}/usr/bin"
    cp ${srcdir}/${app_name}-nativefier "${pkgdir}/usr/bin/${app_name}-nativefier"
    install -Dm644 "${srcdir}/${app_name}-nativefier.desktop" "${pkgdir}/usr/share/applications/${app_name}-nativefier.desktop"
    for _size in "192x192" "128x128" "96x96" "64x64" "48x48" "32x32" "24x24" "22x22" "20x20" "16x16" "8x8"
    do
      install -dm755 "${pkgdir}/usr/share/icons/hicolor/${_size}/apps"
      convert "${srcdir}/${app_name}.png" -strip -resize "${_size}" "${pkgdir}/usr/share/icons/hicolor/${_size}/apps/${app_name}-nativefier.png"
    done
}

package() {
    for app in "${_app_list[@]}"; do
        _package $app 
    done
}
