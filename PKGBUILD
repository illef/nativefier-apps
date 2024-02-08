pkgname=illef-nativefier-apps
pkgver=20221012
pkgrel=1
pkgdesc="illef apps built with nativefier (electron)"
arch=("i686" "x86_64")
license=("custom")
depends=("gtk3" "libxss" "nss")
optdepends=("libindicator-gtk3")
makedepends=("imagemagick" "nodejs-nativefier" "unzip")
source=(
    "keep-nativefier.desktop"
    "calendar-nativefier.desktop"
    "reddit-nativefier.desktop"
    "chatgpt-nativefier.desktop"
    "feedly-nativefier.desktop"
    "keep.png"
    "calendar.png"
    "reddit.png"
    "chatgpt.png"
    "feedly.png"
)
_app_list=(
    "keep;https://keep.google.com"
    "calendar;https://calendar.google.com"
    "reddit;https://www.reddit.com"
    "chatgpt;https://chat.openai.com/chat"
    "feedly;https://feedly.com"
)


_build() {
    app_name=$(echo "$1" | cut -d";" -f1)
    url=$(echo "$1" | cut -d";" -f2)

    nativefier \
      --name "${app_name}" \
      --icon "${app_name}.png" \
      --maximize \
      --lang en-US \
      --honest \
      "${url}"
      # --user-agent "Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101 Firefox/107.0" \
}

build() {
    cd "${srcdir}"

    for app in "${_app_list[@]}"; do
        _build $app 
    done
}

_package() {
    app_name=$(echo "$1" | cut -d";" -f1)

    _folder=$(ls -l "${srcdir}" | grep "$app_name-linux-" | awk '{print $9}')
    _binary=$(ls -l "${srcdir}/${_folder}" | grep "$app_name" | awk '{print $9}')

    install -dm755 "${pkgdir}/"{opt,usr/{bin,share/{applications,licenses/${app_name}-nativefier}}}

    cp -rL "${srcdir}/${_folder}" "${pkgdir}/opt/${app_name}-nativefier"
    ln -s "/opt/${app_name}-nativefier/${_binary}" "${pkgdir}/usr/bin/${app_name}-nativefier"
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
