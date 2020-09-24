#import <XCTest/XCTest.h>
#import "YDOpenSSLManager.h"
#define BANNERWIDTH 30

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
    NSLog(@"%@",[manager getVersion]);
    [self banner];
}

- (void)testCertStoreCreated {
    [self banner];
    NSLog(@"🐝%@",[manager setStoreOfCerts] ? @"Yes" : @"No");
    [self banner];
}

- (void)testReadCertificate {
    [self banner];
    [manager readLocalCertFile];
    [self banner];
}

- (void)testVerifyCertificate {
    [self banner];
    [manager readLocalCertFile];
    [manager verifyCert];
    [self banner];
}

- (void)tearDown {}

@end
