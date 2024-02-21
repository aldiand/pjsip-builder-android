TARGET_ARCHS="armeabi-v7a x86 arm64-v8a x86_64" 

rm -rf ./dist
rm -rf ./output
rm -rf ./tmp

mkdir -p ./dist/android
mkdir -p ./output
mkdir -p ./tmp

for TARGET_ARCH in $TARGET_ARCHS
do
    ./build_openh264.sh $TARGET_ARCH
    ./build_openssl.sh $TARGET_ARCH
    ./build_opus.sh $TARGET_ARCH
    ./build_pjsip.sh $TARGET_ARCH
done