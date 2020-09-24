#import "YDOpenSSLManager.h"

@implementation YDOpenSSLManager

-(instancetype) init{
    if (self = [super init]) {
        NSLog(@"[*] Initializing: %@", NSStringFromClass([self class]));
        NSLog(@"%@", [self getVersion]);

        OPENSSL_init_crypto(OPENSSL_INIT_NO_ADD_ALL_CIPHERS
        | OPENSSL_INIT_NO_ADD_ALL_DIGESTS, NULL);
        certStore = NULL;
        lookup=NULL;
        cert = NULL;
    }
    return self;
}

-(NSString *) getVersion{
    return [NSString stringWithFormat:@"[*] Version: %s", OPENSSL_VERSION_TEXT];
}

-(bool) setStoreOfCerts{

    /* creates an empty X509_STORE structure */
    certStore=X509_STORE_new();
    
    if (certStore == NULL)
        return false;

    /* load certs into X509_STORE from hardcoded default paths. */
    X509_STORE_set_default_paths(certStore);

    // Load trusted CAs from default paths.
    lookup=X509_STORE_add_lookup(certStore,X509_LOOKUP_file());
    
    if (lookup == NULL)
        return false;


    return true;
}

-(void) readLocalCertFile{
    
    NSBundle *appbundle = [NSBundle mainBundle];
    NSString *certpath = [appbundle pathForResource:@"rustyMagnetRootCA2025" ofType:@"pem"];

    if ([[NSFileManager defaultManager] fileExistsAtPath:certpath])
    {
        NSLog(@"[*] Certificate found in App Bundle");
        FILE* certfile = fopen(certpath.fileSystemRepresentation, "r");
        
        if(certfile == NULL)
            NSLog(@"[*] Error reading certificate" );
        
        PEM_read_X509(certfile, &cert, 0, NULL);
    }
}

- (bool) verifyCert {
    
    PEM_write_X509(stdout, cert);

    //    X509_STORE_CTX  *vrfy_ctx = NULL;
//    vrfy_ctx = X509_STORE_CTX_new();
// X509_STORE_CTX_init(vrfy_ctx, store, cert, NULL);
    return false;
}

@end



