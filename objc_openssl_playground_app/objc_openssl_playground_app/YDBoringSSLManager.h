#ifndef YDBoringSSLManager_h
#define YDBoringSSLManager_h

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

#import <Foundation/Foundation.h>
#import "pem.h"
#import "x509.h"
#import "x509_vfy.h"
#import "base64.h"
#import "ssl.h"

@interface YDBoringSSLManager: NSObject{
    X509 *cert;
    X509_STORE *certStore;
    X509_LOOKUP *lookup;
}
- (instancetype) init;
- (NSString *) getVersion;
- (bool) setStoreOfCerts;
- (void) readLocalCertFile;
- (bool) verifyCert;
@end
    
#endif /* YDBoringSSLManager_h */
