mkdir -p ./sources
rm -rf ./sources/*

# Get the source code
cd ./sources

mkdir -p swig
wget http://prdownloads.sourceforge.net/swig/swig-4.2.0.tar.gz -O swig-4.2.0.tar.gz
tar -xvzf swig-4.2.0.tar.gz
rm swig-4.2.0.tar.gz
mv swig-*/* swig
rm -rf swig-*

mkdir -p openh264
wget https://github.com/cisco/openh264/archive/refs/tags/v2.4.1.zip -O openh264-2.4.1.zip
unzip openh264-2.4.1.zip
rm openh264-2.4.1.zip
mv openh264-*/* openh264
rm -rf openh264-*

mkdir -p openssl
wget https://github.com/openssl/openssl/releases/download/openssl-3.2.1/openssl-3.2.1.tar.gz -O openssl-3.2.1.tar.gz
tar -xvzf openssl-3.2.1.tar.gz
rm openssl-3.2.1.tar.gz
mv openssl-*/* openssl
rm -rf openssl-*

mkdir -p opus
wget https://github.com/xiph/opus/releases/download/v1.4/opus-1.4.tar.gz -O opus-1.4.tar.gz
tar -xvzf opus-1.4.tar.gz
rm opus-1.4.tar.gz
mv opus-*/* opus
rm -rf opus-*
mkdir opus/jni
wget https://trac.pjsip.org/repos/raw-attachment/ticket/1904/Android.mk -O opus/jni/Android.mk

mkdir -p pjsip
wget https://github.com/pjsip/pjproject/archive/refs/tags/2.14.zip -O pjproject-2.14.zip
unzip pjproject-2.14.zip
rm pjproject-2.14.zip
mv pjproject-*/* pjsip
rm -rf pjproject-*

