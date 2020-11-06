# OpenSSL code playground
### Setup
Locally build the `OpenSSL` libraries ( `libcrypto.a` and `libssl.a` ) for `iOS`.

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

After building, drag `libcrypto.a` and `libssl.a` into the XCode project. These scripts create `fat binaries` that will work across platforms.  

The `Header` files must be dragged into the project.  When you have multiple architectures inside a single project, make sure the `HEADER_SEARCH_PATHS` and `LIBRARY_SEARCH_PATHS` are set differently for each `Target architecture`.  This helps you avoid `linking` and `missing header file` errors.  For example:

```
HEADER_SEARCH_PATHS = ${SRCROOT}/iOS/**
LIBRARY_SEARCH_PATHS = ${SRCROOT}/iOS/**
```
### Trust Store
`man SSL_CTX_load_verify_locations` gives this statement:

>  When building its own certificate chain, an OpenSSL client/server
       will try to fill in missing certificates from CAfile/CApath, if the certificate chain was not explicitly specified (see
       SSL_CTX_add_extra_chain_cert(3), SSL_CTX_use_certificate(3).


There is a whole step about `X509_STORE_load_locations` using a tool called `c_rehash` to inject a symbolic link into the CA folder.  But this is not required when dealing with the `SSL_CTX` structs.

### Verify Cert Chain - Speed
If you have two different length of certs loaded locally, which chain `verifies` quicker, with OpenSSL?

Chain A  |  Chain B
--|--
Root CA | Root-CA
Int-CA |
Leaf  |



### TLS Version
comment from OpenSSL ssl.h file:
```
/* Negotiate highest available SSL/TLS version */
TLS_client_method()

In code:
SSL_CTX_new(TLS_client_method());
```
### Certificate Authority location on iOS
Located at: `/System/Library/Security/Certificates.bundle`.

### History
The repo started with `OpenSSL-Universal` with `Cocoapods` with `gem` as the package manager.  Then it used `BoringSSL` ( the Google `fork` of `OpenSSL`).  But I moved to `OpenSSL` when I found a way to build it for multiple architectures.  Thankful to `@x2on` for his scripts.

### References

##### Build OpenSSL

Platform  |  Link
--|--
iOS  |  https://github.com/x2on/OpenSSL-for-iPhone
macOS  |  https://github.com/jasonacox/Build-OpenSSL-cURL/
iOS  |  https://lvvme.com/posts/2019/02/16-build_boringssl_for_ios/
General |  https://www.openssl.org/news/openssl-1.1.1-notes.html

##### OpenSSL APIs and Structs
API  |  Link
--|--
X509_STORE | http://www.umich.edu/~x509/ssleay/x509_store.html
Load Certs |  https://www.openssl.org/docs/man1.1.1/man3/X509_STORE_load_locations.html
Verify | https://github.com/openssl/openssl/blob/master/apps/verify.c
Verify  | http://fm4dd.com/openssl/certverify.htm
Verify |  https://stackoverflow.com/questions/3412032/how-do-you-verify-a-public-key-was-issued-by-your-private-ca
Parsing Certs |  https://zakird.com/2013/10/13/certificate-parsing-with-openssl
General |  https://www.youtube.com/watch?v=K4iJ6iK4xPE
X509_STORE |  https://stackoverflow.com/questions/6646841/what-is-the-difference-between-x509-store-and-x509-store-ctx
BIO  |  https://developer.ibm.com/technologies/security/tutorials/l-openssl/
Apple bug  |  https://hynek.me/articles/apple-openssl-verification-surprises/
SSL_CTX_load_verify_locations | https://github.com/openssl/openssl/commit/6dcb100f89d0ef081771d533fed342412ac7a13f
