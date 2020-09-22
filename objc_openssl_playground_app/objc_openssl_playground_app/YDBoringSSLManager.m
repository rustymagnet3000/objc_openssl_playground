#import "YDBoringSSLManager.h"

@implementation YDBoringSSLManager

-(instancetype) init{
    if (self = [super init]) {
        NSLog(@"[*] Initializing: %@", NSStringFromClass([self class]));
        // Initialize OpenSSL
        SSL_library_init();
        SSL_load_error_strings();
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

    OpenSSL_add_all_algorithms();

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



