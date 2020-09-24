#import "YDOpenSSLManager.h"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        YDOpenSSLManager *manager = [[YDOpenSSLManager alloc] init];
        [manager readLocalCertFile];
        
    }
    return 0;
}
