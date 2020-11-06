#ifndef YDOpenSSLHelper_h
#define YDOpenSSLHelper_h

@import Foundation;
#include "x509.h"
#include "pem.h"
#include <openssl/ssl.h>

#define BANNERWIDTH 30

@interface YDOpenSSLHelper: NSObject{}
+(NSString *) getVersion;
+(void) readLocalCertFile;
+(NSString *) getDefaultCertDirectory;
@end

#endif /* YDOpenSSLHelper_h */
