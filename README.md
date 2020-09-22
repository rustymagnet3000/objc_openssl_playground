# OpenSSL Playground with Objective-C
This repo uses the `BoringSSL` fork of `OpenSSL`.
### Setup
Build the two `OpenSSL` libraries - `libcrypto.a` and `libssl.a` - as `fat binaries`.  `fat binaries` for this project equates to: `arm64`, `armv7` and `x86_64`.

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

Once you have the `fat binaries` drag them into your XCode projects.  The `Header` files can also be dragged across.  In the `Target` `Build Settings` you will see the the `HEADER_SEARCH_PATHS` has been set to find the ` header files`.



  [1e12ef73]: https://lvvme.com/posts/2019/02/16-build_boringssl_for_ios/ "build_script_boringssl"

### Certificate Authority location on iOS
Located at: `/System/Library/Security/Certificates.bundle`.

### History
The repo started with `OpenSSL-Universal` with `Cocoapods` with `gem` as the package manager.

Why Objective-C?  Interfacing from Swift to OpenSSL was possible.  But was tidier to code in Objective-C.

## References
##### Build OpenSSL for iOS and macOS
https://github.com/x2on/OpenSSL-for-iPhone
##### Details how to Load Trust Store
https://www.openssl.org/docs/man1.1.1/man3/X509_STORE_load_locations.html
##### The OpenSSL API to Verify a Cert against a Chain
https://github.com/openssl/openssl/blob/master/apps/verify.c
##### Apple standing in for OpenSSL
https://hynek.me/articles/apple-openssl-verification-surprises/
##### Good tips on what OpenSSL APIs to use for Certificates
https://zakird.com/2013/10/13/certificate-parsing-with-openssl
##### Example code to use OpenSSL to Verify a Certificate Chain
http://fm4dd.com/openssl/certverify.htm
##### Some useful pointers on OpenSSL
https://www.youtube.com/watch?v=K4iJ6iK4xPE
##### Understanding the OpenSSL Struct X509-Store
https://stackoverflow.com/questions/6646841/what-is-the-difference-between-x509-store-and-x509-store-ctx
##### Example code to use OpenSSL to Verify a Certificate Chain
https://stackoverflow.com/questions/3412032/how-do-you-verify-a-public-key-was-issued-by-your-private-ca
