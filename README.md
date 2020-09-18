# OpenSSL Playground with Objective-C
Interfacing from Swift to OpenSSL was possible.  It was also messy, compared to Objective-C.

### Setup
To build the two `OpenSSL` libraries - `libcrypto.a` and `libssl.a` you want to build `fat binaries` for `arm64`, `armv7` and `x86_64`.

```
git clone https://github.com/google/boringssl.git boringssl
cd boringssl
mkdir build && cd build
./build.ios
```
The [build script][1e12ef73] is nice and simple.  Remember it requires two tools:
```
brew install cmake
brew install ninja
```
Once you have the `fat binaries` drag them into your XCode projects.  The `Header` files can also be dragged across.

  [1e12ef73]: https://lvvme.com/posts/2019/02/16-build_boringssl_for_ios/ "build_script_boringssl"

### History
Started with `OpenSSL-Universal` with `Cocoapods` with `gem` as the package manager.
Interfacing from Swift to OpenSSL was possible.  It was also messy, compared to Objective-C.

### References
```
https://github.com/openssl/openssl/blob/master/apps/verify.c

https://zakird.com/2013/10/13/certificate-parsing-with-openssl

http://fm4dd.com/openssl/certverify.htm
```
