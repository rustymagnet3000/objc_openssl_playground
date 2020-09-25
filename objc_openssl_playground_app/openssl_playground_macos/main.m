#import "YDOpenSSLManager.h"
#import "YDOpenSSLHelper.h"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        YDOpenSSLManager *manager = [[YDOpenSSLManager alloc] init];
        NSLog(@"%@", [manager getVersion]);
//        [manager printServerResponse];
//        [manager cleanUp];
        [YDOpenSSLHelper readLocalCertFile];
        
    }
    return 0;
}
