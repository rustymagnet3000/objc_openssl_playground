# OpenSSL Playground with Objective-C
### Setup
To build the two `OpenSSL` libraries - `libcrypto.a` and `libssl.a` - build `fat binaries` for `arm64`, `armv7` and `x86_64`. This repo uses the `BoringSSL` fork of `OpenSSL`.

```
git clone https://github.com/google/boringssl.git boringssl
cd boringssl
mkdir build && cd build
```
Get the [build script][1e12ef73]:
```
./build.ios
```
The script requires two tools:
```
brew install cmake
brew install ninja
```

Once you have the `fat binaries` drag them into your XCode projects.  The `Header` files can also be dragged across.

  [1e12ef73]: https://lvvme.com/posts/2019/02/16-build_boringssl_for_ios/ "build_script_boringssl"

### History
Started with `OpenSSL-Universal` with `Cocoapods` with `gem` as the package manager.

Why Objective-C?  Interfacing from Swift to OpenSSL was possible.  But was tidier to code in Objective-C.

### References
```
https://github.com/openssl/openssl/blob/master/apps/verify.c

https://zakird.com/2013/10/13/certificate-parsing-with-openssl

http://fm4dd.com/openssl/certverify.htm
```
