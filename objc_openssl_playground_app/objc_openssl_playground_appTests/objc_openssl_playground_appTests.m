@import XCTest;
#import "YDOpenSSLManager.h"
#import "YDOpenSSLHelper.h"
#define MAX_TESTS 50

@interface objc_openssl_playground_appTests : XCTestCase
@end

@implementation objc_openssl_playground_appTests

    YDOpenSSLManager *manager;

    - (void)setUp {
        self.continueAfterFailure = NO;
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
        manager = [[YDOpenSSLManager alloc] init];
         
        if (manager != nil){
            // [manager printServerResponse];
            [manager cleanUp];
        }
        [self banner];
    }

    - (void)testSpeedOfInit {
        int successCount = 0;
        for (int i = 0; i < MAX_TESTS; i++) {
            manager = [[YDOpenSSLManager alloc] init];
            if (manager != nil){
                successCount++;
                [manager cleanUp];
            }
        }
        assert(successCount == MAX_TESTS);
        NSLog(@"[*]Complete %d", successCount);
        
    }

    - (void)testReadCertificate {
        [self banner];
        [YDOpenSSLHelper readLocalCertFile];
        [self banner];
    }

    - (void)tearDown {
            //
    }

@end
