#import <XCTest/XCTest.h>
#import "pem.h"
#include <openssl/crypto.h>
#include <openssl/pem.h>
#include <openssl/x509.h>
#include <openssl/x509_vfy.h>



#define BANNERWIDTH 30

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

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
  //  puts(OPENSSL_VERSION_TEXT);
    [self banner];
}

- (void)testReadCertificate {
    [self banner];

    X509 *cert = NULL;
    NSBundle *appbundle = [NSBundle mainBundle];
    NSString *certpath = [appbundle pathForResource:@"rustyMagnetRootCA2025" ofType:@"pem"];

    if ([[NSFileManager defaultManager] fileExistsAtPath:certpath])
    {
        NSLog(@"Certificate found in App Bundle");
        FILE* certfile = fopen(certpath.fileSystemRepresentation, "r");
        XCTAssertTrue(certfile, @"[*] Error reading certificate" );
        
        PEM_read_X509(certfile, &cert, 0, NULL);
    }

    [self banner];
}


@end
