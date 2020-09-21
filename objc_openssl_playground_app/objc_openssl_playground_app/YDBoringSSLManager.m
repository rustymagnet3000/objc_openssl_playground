#import <YDBoringSSLManager.h>

@implementation YDBoringSSLManager

-(instancetype) init{
    if (self = [super init]) {
        NSLog(@"wow");
    }
    return self;
}

-(NSString *) getDescription{

    return @"Hello";
}

-(void) readLocalCertFile{
    
    X509 *cert = NULL;
    NSBundle *appbundle = [NSBundle mainBundle];
    NSString *certpath = [appbundle pathForResource:@"rustyMagnetRootCA2025" ofType:@"pem"];

    if ([[NSFileManager defaultManager] fileExistsAtPath:certpath])
    {
        NSLog(@"Certificate found in App Bundle");
        FILE* certfile = fopen(certpath.fileSystemRepresentation, "r");
        
        if(certfile == NULL)
            NSLog(@"[*] Error reading certificate" );
        
        PEM_read_X509(certfile, &cert, 0, NULL);
        PEM_write_X509(stdout, cert);
    }
}


@end


