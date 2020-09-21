#import <XCTest/XCTest.h>
#define BANNERWIDTH 30

@interface objc_openssl_playground_appTests : XCTestCase

@end

@implementation objc_openssl_playground_appTests

- (void)setUp {
    self.continueAfterFailure = NO;
}

- (void)tearDown {}
- (void)banner{
    NSLog(@"%@", [@"" stringByPaddingToLength:BANNERWIDTH withString:@"-" startingAtIndex:0]);
}


- (void)testOpenSSLVersion {
    [self banner];

    [self banner];
}

- (void)testReadCertificate {
    [self banner];

    [self banner];
}


@end
