
#import "TMDataCenter.h"
#import "TMDataRequest.h"
//TMData Class Extension

@interface TMDataCenter ()


@end


//TMData Implementation

@implementation TMDataCenter

#pragma mark - init

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

#pragma mark - TMData Singleton (Global Data)

static TMDataCenter* _center = nil;

+ (id)center
{
	static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _center = [[self alloc] init];
    });
	return _center;
}

+ (void)unload
{
    [_center release];
    _center = nil;
}

#pragma mark - Request

- (void)sendRequest:(TMDataRequest *)request options:(TMRequestOption)option
{
    dispatch_queue_t concurrentQueue = NULL;
    
    if (option & TMRequestOptionConcurrent)
    {
        concurrentQueue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
        
    }
    
    if (option & TMRequestOptionAsync)
    {
        dispatch_async(dispatch_get_current_queue(), ^{
            //send to http
            
        });
    }
}
@end
