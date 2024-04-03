#!env bash
SOURCE_PATH=$1
OUTPUT_PATH=$2
BUILD_COMMAND=$3

rm -Rf web
cp -R "$SOURCE_PATH" web/
$3
rm -Rf "$OUTPUT_PATH"
mv  "build/web" "$OUTPUT_PATH"
rm -Rf web