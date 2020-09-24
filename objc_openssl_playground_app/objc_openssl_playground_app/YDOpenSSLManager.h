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


@interface YDOpenSSLManager: NSObject{
    X509 *cert;
    X509_STORE *certStore;
    X509_LOOKUP *lookup;
    FILE* certfile;
}

- (instancetype) init;
- (NSString *) getVersion;
- (BOOL) setStoreOfCerts;
- (BOOL) readLocalCertFile;
- (BOOL) verifyCert;
@end
    
#endif /* YDOpenSSSSLManager_h */
