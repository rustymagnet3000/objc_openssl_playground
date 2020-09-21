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
#import "base64.h"

@interface YDBoringSSLManager: NSObject
- (instancetype) init;
- (NSString *) getVersion;
- (void) readLocalCertFile;
@end
    
#endif /* YDBoringSSLManager_h */
