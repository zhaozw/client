

#import "TMNetworkHandler.h"

#import "AFNetworking.h"

//json parser
#import "JSONKit.h"

#warning should define in a certain config file include error
static CGFloat NetworkRequestTimeoutInterval = 10.0f;

#define ErrorDescriptionPath [[NSBundle mainBundle] pathForResource:@"ErrorDescription" ofType:@"plist"]

@interface TMNetworkHandler (){
    AFHTTPClient* _client;
    
    NSDictionary* _errorDescriptionDict;
}

//json
- (NSDictionary *)dictFromJSON:(NSString *)json;

//error description
- (NSString *)errorLocalizedDescriptionWithCode:(NSInteger)code;

@end

@implementation TMNetworkHandler

#pragma mark - init

- (id)initWithServerBaseURL:(NSURL *)baseURL
{
    self = [super init];
    
    _client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    return self;
}

#pragma mark - main

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
    //gen request
    NSURLRequest* request = [_client requestWithMethod:method path:path parameters:paramsDict];
    
    //gen request operation
    AFHTTPRequestOperation* operation = [_client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
            //get error code's description from mapping
            NSString* description = [self errorLocalizedDescriptionWithCode:errorCode];
            NSDictionary* userInfo = @{NSLocalizedDescriptionKey : description};
            
            //gen a error object
            NSError* error = [NSError errorWithDomain:@"TMNetworkDomain" code:errorCode userInfo:userInfo];
            
            //notify
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

#pragma mark - Private

//parse json, using JSONKit

- (NSDictionary *)dictFromJSON:(NSString *)json
{
    return [json objectFromJSONString];
}

//error description

- (NSString *)errorLocalizedDescriptionWithCode:(NSInteger)code
{
    if (!_errorDescriptionDict)
    {
        _errorDescriptionDict = [[NSDictionary alloc] initWithContentsOfFile:ErrorDescriptionPath];
    }
    
    NSString* codeKey = [NSString stringWithFormat:@"%d", code];
    NSString* codeValue = [_errorDescriptionDict valueForKey:codeKey];
    
    return codeValue;
    
}

#pragma mark - Dealloc

- (void)dealloc
{
    [_client release];
    _client = nil;
    
    [_errorDescriptionDict release];
    _errorDescriptionDict = nil;
    
    [super dealloc];
}
@end
