#ifndef YDBoringSSLManager_h
#define YDBoringSSLManager_h

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

#import <Foundation/Foundation.h>
#import "pem.h"
#include <openssl/crypto.h>
#include <openssl/pem.h>
#include <openssl/x509.h>
#include <openssl/x509_vfy.h>

@interface YDBoringSSLManager: NSObject
- (instancetype) init;
- (NSString *) getDescription;
- (void) readLocalCertFile;
@end
    
#endif /* YDBoringSSLManager_h */
