TARGET_ARCHS="armeabi-v7a x86 arm64-v8a x86_64" 

rm -rf ./dist/android
mkdir -p ./dist/android/src/main
cp -r output/pjsip/* ./dist/android/src/main

for TARGET_ARCH in $TARGET_ARCHS
do
    mkdir -p ./dist/android/src/main/jniLibs/${TARGET_ARCH}
    cp -r output/openh264/${TARGET_ARCH}/lib/libopenh264.so dist/android/src/main/jniLibs/${TARGET_ARCH}/libopenh264.so
done

rm release.tar.gz
cd dist

tar -czvf ../release.tar.gz ./