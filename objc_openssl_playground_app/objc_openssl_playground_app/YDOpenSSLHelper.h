#ifndef YDOpenSSLHelper_h
#define YDOpenSSLHelper_h

#import <Foundation/Foundation.h>
#include "x509.h"
#include "pem.h"

@interface YDOpenSSLHelper: NSObject{}
    
+(void) readLocalCertFile;
@end

#endif /* YDOpenSSLHelper_h */
