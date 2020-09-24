# OpenSSL Playground with Objective-C
This repo uses `OpenSSL`.  Brief notes on version changes are written here:

https://www.openssl.org/news/openssl-1.1.1-notes.html

### Setup
Build the two `OpenSSL` libraries `libcrypto.a` and `libssl.a`.

```
git clone https://github.com/x2on/OpenSSL-for-iPhone.git
cd OpenSSL-for-iPhone
./build-libssl.sh -targets="ios-sim-cross-x86_64 ios64-cross-arm64 ios64-cross-arm64e"
```
If you want a `macOS Target`:
```
git clone https://github.com/jasonacox/Build-OpenSSL-cURL.git
cd Build-OpenSSL-cURL/
./build.sh -o 1.1.1g -d -b
```

These scripts create `fat binaries`.  After building, drag `libcrypto.a` and `libssl.a` into the XCode project.

The `Header` files must be dragged into the project.  When you have multiple architectures inside a single project, make sure the `HEADER_SEARCH_PATHS` and `LIBRARY_SEARCH_PATHS` can differentiate to avoid linking errors and missing header errors.  For example:

```
//:configuration = Debug
HEADER_SEARCH_PATHS = ${SRCROOT}/iOS/**
LIBRARY_SEARCH_PATHS = ${SRCROOT}/iOS/**
```


### Certificate Authority location on iOS
Located at: `/System/Library/Security/Certificates.bundle`.

### History
The repo started with `OpenSSL-Universal` with `Cocoapods` with `gem` as the package manager.  Then it used `BoringSSL` ( the Google `fork` of `OpenSSL`).

## References
##### Build OpenSSL for iOS
https://github.com/x2on/OpenSSL-for-iPhone
##### Build OpenSSL and cURL for macOS
https://github.com/jasonacox/Build-OpenSSL-cURL/
##### Build BoringSSL for iOS
https://lvvme.com/posts/2019/02/16-build_boringssl_for_ios/
##### Details how to Load Trust Store
https://www.openssl.org/docs/man1.1.1/man3/X509_STORE_load_locations.html
##### The OpenSSL API to Verify a Cert against a Chain
https://github.com/openssl/openssl/blob/master/apps/verify.c
##### Apple standing in for OpenSSL. Excellent sample code
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
