
#import "TMDataFacade.h"

#import "TMDataCache.h"

#import "AFNetworking.h"
@interface TMDataFacade ()
{
    //components
    TMDataCache* _cache;    //local cache
    
    

}

- (void)dispatch:(void(^)(void))requestBlock;

@end

//queues
static dispatch_queue_t _cacheQueue;   //serial queue for cache

static dispatch_queue_t _concurrentQueue;

@implementation TMDataFacade

#pragma mark - Singleton

static TMDataFacade* _facade = nil;

- (id)init
{
    self = [super init];
    if (self)
    {
        //cache
        _cache = [[TMDataCache alloc] init];
        
        
        //cache queue
        _cacheQueue = dispatch_queue_create("cache_queue", DISPATCH_QUEUE_SERIAL);
        
        //concurrent queue
        _concurrentQueue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

+ (id)facade
{
	static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _facade = [[self alloc] init];
    });
	return _facade;
}

+ (void)unload
{
    [_facade release];
    _facade = nil;
}

#pragma mark - Private Class Extensions

//dispatcher
- (void)dispatch:(void (^)(void))requestBlock
{
}

#pragma mark - Requests

- (void)requestAvatarWithURL:(NSURL *)url
                         uid:(NSString *)uid
                   timestamp:(NSString *)timestamp
                     success:(void (^)(UIImage *))sBlock
                        fail:(void (^)(NSInteger))fBlock
{
    //push in concurrent queue
    dispatch_async(_concurrentQueue, ^{
        
        //check cache sync in cache queue
        __block BOOL isLatest;
        __block UIImage* avatar = nil;
        
        //search cache
        dispatch_sync(_cacheQueue, ^{
            avatar = [_cache avatarWithUID:uid timestamp:timestamp isLatest:&isLatest];
        });
        
        //cached
        if (avatar)
        {
            //retain for main queue
            [avatar retain];
            //notify main queue
            dispatch_async(dispatch_get_main_queue(), ^{
                if(sBlock)
                {
                    sBlock([avatar autorelease]);
                }
            });
        }
        //return when avatar is latest
        if(isLatest)
        {
            return;
        }
        //not cached
        else
        {
            NSURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
            
            AFImageRequestOperation* op = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                
                //notify main queue
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(sBlock) {sBlock(image);}
                });
                //async cache avatar
                dispatch_async(_cacheQueue, ^{
                    [_cache cacheAvatar:image uid:uid timestamp:timestamp];
                });
                
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
        
    });
    
}

@end
