

#import "TMNetworkHandler.h"

#import "AFNetworking.h"

//json parser
#import "JSONKit.h"

static CGFloat NetworkRequestTimeoutInterval = 30.0f;

@implementation TMNetworkHandler

- (void)imageRequestWithURL:(NSURL *)url
                    success:(void (^)(UIImage *))sBlock
                       fail:(NetworkReqeustFailBlock)fBlock
{
    //generate a URL request
    NSURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:NetworkRequestTimeoutInterval];
    
    //use AFNetworking's image request operation
    void(^successBlock)(NSURLRequest*, NSHTTPURLResponse*, UIImage*) = ^(NSURLRequest* r, NSHTTPURLResponse* res, UIImage* image){
        if (sBlock) sBlock(image);
    };
    void(^failBlock)(NSURLRequest*, NSHTTPURLResponse*, NSError*) = ^(NSURLRequest* r, NSHTTPURLResponse* res, NSError* error){
        if (fBlock) fBlock(error);
    };
    
    AFImageRequestOperation* op = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:successBlock failure:failBlock];
        
    
    //start request operation
    [op start];
}

- (void)httpRequestWithPath:(NSString *)path
                     method:(NSString *)method
                     params:(NSDictionary *)paramsDict
                    success:(NetworkRequestSuccessBlock)sBlock
                       fail:(NetworkReqeustFailBlock)fBlock
{
    //test base url localhost
    NSURL* baseURL = [NSURL URLWithString:@"http://127.0.0.1:8000"];
    
    //client
    AFHTTPClient* client = [AFHTTPClient clientWithBaseURL:baseURL];
    
    //gen request
    NSURLRequest* request = [client requestWithMethod:method path:path parameters:paramsDict];
    
    //gen request operation
    AFHTTPRequestOperation* operation = [client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //json to dict
        NSDictionary* responseDict = [operation.responseString objectFromJSONString];
        
        //error code
        NSInteger errorCode = [[responseDict objectForKey:@"error"] integerValue];
        
        //normal
        if (errorCode == 0)
        {
            if (sBlock)
            {
                sBlock([responseDict objectForKey:@"data"]);
            }
        }
        //unnormal
        else
        {
            NSDictionary* userInfo = [NSDictionary dictionaryWithObject:@"hahah" forKey:NSLocalizedDescriptionKey];
            NSError* error = [NSError errorWithDomain:@"TMNetworkDomain" code:errorCode userInfo:userInfo];
          
            if (fBlock)
            {
                fBlock(error);
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //fail
        if (fBlock)
        {
            fBlock(error);
        }
    }];
    
    //start operation
    [operation start];
}
@end
