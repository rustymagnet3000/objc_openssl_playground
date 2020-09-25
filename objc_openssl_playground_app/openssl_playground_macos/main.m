#import "YDOpenSSLManager.h"
#import <Foundation/Foundation.h>
# include  "openssl/bio.h"
# include  "openssl/ssl.h"
# include  "openssl/err.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        YDOpenSSLManager *manager = [[YDOpenSSLManager alloc] init];
        [manager cleanUp];
    }
    return 0;
}
