#!env sh
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
FULL_PATH_TO_SCRIPT="$(realpath "$0")"
SCRIPT_DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"
BUILD_PARAMS=$@

cd "$SCRIPT_DIRECTORY/../web_chrome_extension" && npm install && npm run clean && npm run build && cd -

. "$SCRIPT_DIRECTORY/lib/build_web.sh" "web_chrome_extension/dist" "build/chrome-extension" "flutter build web --no-web-resources-cdn --csp $BUILD_PARAMS"