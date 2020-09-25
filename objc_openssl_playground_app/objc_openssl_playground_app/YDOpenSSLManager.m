#import "YDOpenSSLManager.h"

int verify(int ok, X509_STORE_CTX *store)
{
    X509_STORE_CTX_set_error(store, X509_V_ERR_APPLICATION_VERIFICATION);
    return 0;
}

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
        certfile = NULL;
        appbundle = [NSBundle mainBundle];
        ctx = SSL_CTX_new(SSLv23_client_method());
        
        if([self loadTrustStore] == NO)
            return NULL;
        
        if ([self createConnection] == NO)
            return NULL;
        

    }
    return self;
}

-(BOOL) createConnection{
    BIO_set_conn_hostname(bio, "127.0.0.1:8443");

//    if(bio == NULL)
//        return NO;

    if(BIO_do_connect(bio) <= 0)
        return NO;
    
    bio = BIO_new_ssl_connect(ctx);
    BIO_get_ssl(bio, & ssl);
    SSL_set_mode(ssl, SSL_MODE_AUTO_RETRY);
    NSLog(@"[*] Connection created");
    return YES;
}



-(NSString *) getVersion{
    return [NSString stringWithFormat:@"[*] Version: %s", OPENSSL_VERSION_TEXT];
}

-(BOOL) loadTrustStore{

    const char *cert_folder = [[appbundle resourcePath] UTF8String];
    if(! SSL_CTX_load_verify_locations(ctx, NULL, cert_folder))
        return NO;
    NSLog(@"[*] loaded trust store from Folder");
    return YES;
}

-(BOOL) readLocalCertFile{
    
    
    NSString *certpath = [appbundle pathForResource:@"rustyMagnetRootCA2025" ofType:@"pem"];

    if ([[NSFileManager defaultManager] fileExistsAtPath:certpath])
    {
        NSLog(@"[*] Certificate found in App Bundle");
        certfile = fopen(certpath.fileSystemRepresentation, "r");
        
        if(certfile != NULL)
            return TRUE;
    }
    NSLog(@"[*] Error reading local cert");
    return NO;
}

- (void) printLocalCertFile {
    PEM_read_X509(certfile, &cert, 0, NULL);
    PEM_write_X509(stdout, cert);
}

- (BOOL) verifyCert {
    

    //    X509_STORE_CTX  *vrfy_ctx = NULL;
//    vrfy_ctx = X509_STORE_CTX_new();
// X509_STORE_CTX_init(vrfy_ctx, store, cert, NULL);
    return false;
}

@end



