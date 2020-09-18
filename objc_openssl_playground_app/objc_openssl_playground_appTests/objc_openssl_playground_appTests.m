#import <XCTest/XCTest.h>
#include <openssl/opensslv.h>
#include <openssl/crypto.h>
#define BANNERWIDTH 30

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

@interface objc_openssl_playground_appTests : XCTestCase

@end

@implementation objc_openssl_playground_appTests

- (void)setUp {}
- (void)tearDown {}
- (void)banner{
    NSLog(@"%@", [@"" stringByPaddingToLength:BANNERWIDTH withString:@"-" startingAtIndex:0]);
}


- (void)testOpenSSLVersion {
    [self banner];
    puts(OPENSSL_VERSION_TEXT);
    [self banner];
}



@end
