#!env sh
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
FULL_PATH_TO_SCRIPT="$(realpath "$0")"
SCRIPT_DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"

. "$SCRIPT_DIRECTORY/lib/build_web.sh" "web_browser" "build/webapp" "flutter build web --web-renderer canvaskit --release"