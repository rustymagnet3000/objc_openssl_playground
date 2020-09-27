#import "YDOpenSSLManager.h"
#import "YDOpenSSLHelper.h"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        YDOpenSSLManager *manager = [[YDOpenSSLManager alloc] init];
        NSLog(@"%@", [YDOpenSSLHelper getVersion]);
        
        if(manager != NULL){
            [manager printServerResponse];
            [manager cleanUp];
        }
        
    }
    return 0;
}
