#import "YDOpenSSLManager.h"

@implementation YDOpenSSLManager

-(instancetype) init{
    if (self = [super init]) {
        NSLog(@"[*] Initializing: %@", NSStringFromClass([self class]));
        
        OPENSSL_init_crypto(OPENSSL_INIT_NO_ADD_ALL_CIPHERS
        | OPENSSL_INIT_NO_ADD_ALL_DIGESTS, NULL);
        certStore = NULL;
        cafilespath = [[NSProcessInfo processInfo] environment][@"CAFILES"];
        lookup=NULL;
        ctx = NULL;

        if([self verifyTrustStoreDirExists] == NO)
            return NULL;

        if([self connectionSetup] == NO)
            return NULL;
        
        if([self loadTrustStore] == NO)
            return NULL;
    
 
    }
    return self;
}

-(BOOL) verifyTrustStoreDirExists{
    BOOL isDir = NO;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    [fileManager fileExistsAtPath:cafilespath isDirectory:&isDir];
    return isDir;
}


-(BOOL) connectionSetup{

    ctx = SSL_CTX_new(TLS_client_method());
    bio = BIO_new_ssl_connect(ctx);
    
    BIO_set_conn_hostname(bio, HOSTANDPORT);
    
    if(bio == NULL)
        return NO;

    if(BIO_do_connect(bio) <= 0){
        fprintf(stderr, "Error connecting to server\n");
        return NO;
    }
    
    BIO_get_ssl(bio, & ssl);
    SSL_set_mode(ssl, SSL_MODE_AUTO_RETRY);
        
    NSLog(@"[*] Connection created");
    return YES;
}

-(BOOL) loadTrustStore{

    if(SSL_CTX_load_verify_locations(ctx, NULL, cafilespath.fileSystemRepresentation) == 0)
        return NO;
    NSLog(@"[*] loaded trust store from Folder");
    
    if(![self verifyPeerCertificates])
        return NO;
    
    return YES;
}

-(BOOL) verifyPeerCertificates{
    
    const long result = SSL_get_verify_result(ssl);
    switch (result) {
        case X509_V_OK:
            fprintf(stdout, "[*] Happy path\n");
            return YES;
        case X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT_LOCALLY:
            fprintf(stderr, "[*] Can't find certificate\n");
            return NO;
        case X509_V_ERR_SELF_SIGNED_CERT_IN_CHAIN:
            fprintf(stdout, "[*] Self signed certificate chain. Proceed\n");
            return YES;
        default:
            fprintf(stderr, "[*] Unexpected error: %ld\n", result);
            return NO;
    }
}

-(void) printServerResponse{
    char tmpbuf[BUFFER];
    int len;
    output = BIO_new_fp(stdout, BIO_NOCLOSE);
    BIO_puts(bio, "GET / HTTP/1.0\n\n");
    
    for ( ; ; ) {
        len = BIO_read(bio, tmpbuf, BUFFER);
        if (len <= 0)
            break;
        BIO_write(output, tmpbuf, len);
    }
}

-(void) cleanUp{
    BIO_free(bio);
    BIO_free(output);
    SSL_CTX_free(ctx);
    ssl = NULL;
    NSLog(@"[*] Clean-up done");
}



@end



