#import "YDOpenSSLHelper.h"

@implementation YDOpenSSLHelper

+(NSString *) getVersion{
    return [NSString stringWithFormat:@"[*]version: %s", OPENSSL_VERSION_TEXT];
}

+(NSString *) getDefaultCertDirectory{
    
    const char *dir;
    dir = X509_get_default_cert_dir();
    return [NSString stringWithFormat:@"[*]default_cert_dir: %@", [NSString stringWithUTF8String:dir]];
}

+(void) readLocalCertFile{
    NSString *certpath = [[NSBundle mainBundle] pathForResource:@"/rustyMagnetRootCA2025" ofType:@"pem"];
    
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
    else {
        NSLog(@"[!]Error reading local cert");
    }
}

@end
