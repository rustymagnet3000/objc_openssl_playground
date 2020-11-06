#ifndef YDOpenSSLManager_h
#define YDOpenSSLManager_h

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

@import Foundation;
#include "pem.h"
#include "x509.h"
#include "x509_vfy.h"
#include "ssl.h"
#include "err.h"
#include <dirent.h>

#define HOSTANDPORT "127.0.0.1:8443"
#define BUFFER 1024
#define CA_FILES "/ca_files"

@interface YDOpenSSLManager: NSObject{
    X509_STORE *cert_store;
    X509_LOOKUP *lookup;
    SSL_CTX *ctx;
    SSL *ssl;
    BIO *bio, *output;
    NSString *ca_dir_path;
}

-(instancetype) init;
-(void) printServerResponse;
-(void) cleanUp;

@end
    
#endif /* YDOpenSSSSLManager_h */
