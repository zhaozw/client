

#import "TMNetworkHandler.h"

#import "AFNetworking.h"

static CGFloat NetworkRequestTimeoutInterval = 30.0f;

@implementation TMNetworkHandler

- (void)imageRequestWithURL:(NSURL *)url
                    success:(void (^)(UIImage *))sBlock
                       fail:(void (^)(NSInteger))fBlock
{
    //generate a URL request
    NSURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:NetworkRequestTimeoutInterval];
    
    //use AFNetworking's image request operation
    AFImageRequestOperation* op = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        if (sBlock)
        {
            sBlock(image);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        //notify main queue
        dispatch_async(dispatch_get_main_queue(), ^{
#warning fake error code
            if(fBlock) {fBlock(999);}
        });
        
    }];
    
    //start request operation
    [op start];
}
@end
