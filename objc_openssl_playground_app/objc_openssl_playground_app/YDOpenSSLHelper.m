#import "YDOpenSSLHelper.h"

@implementation YDOpenSSLHelper

+(NSString *) getVersion{
    return [NSString stringWithFormat:@"[*] Version: %s", OPENSSL_VERSION_TEXT];
}

+(void) readLocalCertFile{
    NSString *certpath = [[NSBundle mainBundle] pathForResource:@"/cafiles/rustyMagnetRootCA2025" ofType:@"pem"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:certpath])
    {
        NSLog(@"[*] Certificate found in App Bundle");
        FILE* certfile = fopen(certpath.fileSystemRepresentation, "r");
        
        if(certfile == NULL)
            return;
        
        X509 *cert = NULL;
        PEM_read_X509(certfile, &cert, 0, NULL);
        PEM_write_X509(stdout, cert);
    }
    NSLog(@"[*] Error reading local cert");
}

@end
