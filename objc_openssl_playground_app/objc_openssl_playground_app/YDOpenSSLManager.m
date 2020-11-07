#import "YDOpenSSLManager.h"

@implementation YDOpenSSLManager

-(instancetype) init{
    if (self = [super init]) {
        NSLog(@"[*]Initializing: %@", NSStringFromClass([self class]));
        
        OPENSSL_init_crypto(OPENSSL_INIT_NO_ADD_ALL_CIPHERS
        | OPENSSL_INIT_NO_ADD_ALL_DIGESTS, NULL);
        cert_store = nil;
        ca_dir_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@CA_FILES];
        lookup = nil;
        ctx = nil;

        if ([self verifyTrustStoreDirExists] == NO)
            return nil;

        if ([self connectionSetup] == NO)
            return nil;
        
        if ([self loadTrustStore] == NO)
            return nil;
    
        if([self verifyPeerCertificates] == NO)
            return nil;
        
        NSLog(@"[*]Initialization succeeded");
        
    }
    return self;
}

-(BOOL) verifyTrustStoreDirExists{
    BOOL isDir = NO;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    [fileManager fileExistsAtPath:ca_dir_path isDirectory:&isDir];
    return isDir;
    NSLog(@"[*]Found directory of Cert Authority certificates");
}


-(BOOL) connectionSetup{

    ctx = SSL_CTX_new(TLS_client_method());
    bio = BIO_new_ssl_connect(ctx);
    
    BIO_set_conn_hostname(bio, HOSTANDPORT);
    
    if(bio == NULL)
        return NO;

    if(BIO_do_connect(bio) <= 0){
        fprintf(stderr, "[!]Error connecting to server\n");
        return NO;
    }
    
    BIO_get_ssl(bio, & ssl);
    SSL_set_mode(ssl, SSL_MODE_AUTO_RETRY);
        
    NSLog(@"[*]Connection created");
    return YES;
}
-(void) printtPeerCerts{
    X509 *cert = SSL_get_peer_certificate(ssl);
    STACK_OF(X509) *sk = sk_X509_new_null();
    sk_X509_push(sk, cert);
    
    for (int i=1; i < sk_X509_num(sk); i++) {
        printf("%i", i);
    }
    
    NSLog(@"[*]Peer certs");
}

-(BOOL) loadTrustStore{

    if(SSL_CTX_set_default_verify_paths(ctx) == 0)
        return NO;
    cert_store = SSL_CTX_get_cert_store(ctx);
    
    [self printtPeerCerts];
    
    if(SSL_CTX_load_verify_locations(ctx, NULL, ca_dir_path.fileSystemRepresentation) == 0)
        return NO;
    
    NSLog(@"[*]SSL_CTX_set_default_verify_paths and loaded trust store from Folder");
    return YES;
}

-(BOOL) verifyPeerCertificates{
    
    const long result = SSL_get_verify_result(ssl);
    switch (result) {
        case X509_V_OK:
            fprintf(stdout, "[*]Happy path\n");
            return YES;
        case X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT_LOCALLY:
            fprintf(stderr, "[!]Can't find certificate. Code:%ld\n", result);
            return NO;
        case X509_V_ERR_SELF_SIGNED_CERT_IN_CHAIN:
            fprintf(stdout, "[*]Self signed certificate chain. Proceed\n");
            return YES;
        default:
            fprintf(stderr, "[!]Unexpected error: %ld\n", result);
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
    NSLog(@"[*]Clean-up done");
}

@end
