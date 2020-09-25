#ifndef YDOpenSSLManager_h
#define YDOpenSSLManager_h

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

#import <Foundation/Foundation.h>
#include "pem.h"
#include "x509.h"
#include "x509_vfy.h"
#include "ssl.h"
#include <openssl/err.h>
#include <dirent.h>

#define HOSTANDPORT "127.0.0.1:8443"
#define BUFFER 1024

@interface YDOpenSSLManager: NSObject{
    X509 *cert;
    X509_STORE *certStore;
    X509_LOOKUP *lookup;
    NSBundle *appbundle;
    SSL_CTX *ctx;
    SSL *ssl;
    BIO *bio, *output;
    NSString *cafilespath;
    FILE* certfile;
}

- (instancetype) init;
- (NSString *) getVersion;
- (BOOL) readLocalCertFile;
- (BOOL) createConnection;
- (void) printServerResponse;
- (void) cleanUp;

@end
    
#endif /* YDOpenSSSSLManager_h */
