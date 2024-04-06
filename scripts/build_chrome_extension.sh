#!env sh
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
FULL_PATH_TO_SCRIPT="$(realpath "$0")"
SCRIPT_DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"

cd "$SCRIPT_DIRECTORY/../web chrome extension" && npm run clean && npm run build && cd -

. "$SCRIPT_DIRECTORY/lib/build_web.sh" "web chrome extension/dist" "build/chrome-extension" "flutter build web --web-renderer html --csp"