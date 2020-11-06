@import XCTest;
#import "YDOpenSSLManager.h"
#import "YDOpenSSLHelper.h"


@interface objc_openssl_playground_appTests : XCTestCase
@end

@implementation objc_openssl_playground_appTests

    YDOpenSSLManager *manager;

    - (void)setUp {
        self.continueAfterFailure = NO;
        manager = [[YDOpenSSLManager alloc] init];
    }

    - (void)banner{
        NSLog(@"%@", [@"" stringByPaddingToLength:BANNERWIDTH withString:@"-" startingAtIndex:0]);
    }


    - (void)testOpenSSLVersion {
        [self banner];
        NSLog (@"%@", [YDOpenSSLHelper getVersion]);
        [self banner];
    }

    - (void)testInitVerifyAndPrintResponse {
        [self banner];
        if (manager != NULL){
            [manager cleanUp];
        }
        [self banner];
    }

    - (void)testReadCertificate {
        [self banner];
        [YDOpenSSLHelper readLocalCertFile];
        [self banner];
    }

    - (void)tearDown {}

@end
