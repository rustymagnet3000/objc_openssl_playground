#import "YDOpenSSLManager.h"
#import "YDOpenSSLHelper.h"
@import Foundation;

int main () {
    @autoreleasepool {
        NSLog (@"%@", [YDOpenSSLHelper getVersion]);
        
        YDOpenSSLManager *manager = [[YDOpenSSLManager alloc] init];
        if (manager != nil){
            [manager printServerResponse];
            [manager cleanUp];
        }
        
    }
    return 0;
}
