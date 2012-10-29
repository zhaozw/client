
#import "TMDataFacade.h"

#import "AFNetworking.h"

@interface TMDataFacade ()
{
    //queues
    dispatch_queue_t _facadeQueue;//concurrent
    dispatch_queue_t _cacheQueue;//serial
    
    
    //handlers
    TMCacheHandler*     _cacheHandler;
    TMNetworkHandler*   _networkHandler;
    
    //models
    

}

@end

@implementation TMDataFacade

#pragma mark - Singleton

static TMDataFacade* _facade = nil;

- (id)init
{
    self = [super init];
    if (self)
    {
        //init queues
        const char* facadeQueueLabel = "Tiniman.Data.Facade.FacadeQueue";
        _facadeQueue = dispatch_queue_create(facadeQueueLabel, DISPATCH_QUEUE_CONCURRENT);
        const char* cacheQueueLabel = "Tiniman.Data.Facade.CacheQueue";
        _cacheQueue = dispatch_queue_create(cacheQueueLabel, DISPATCH_QUEUE_SERIAL);
        
        //init handlers
        _cacheHandler = [[TMCacheHandler alloc] init];
        _networkHandler = [[TMNetworkHandler alloc] init];
        
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
    //queues
    [_facade release];
    _facade = nil;
    
}

- (void)dealloc
{
    //queues
    dispatch_release(_facadeQueue);
    _facadeQueue = nil;
    dispatch_release(_cacheQueue);
    _cacheQueue = nil;
    
    //handlers
    [_cacheHandler release];
    _cacheHandler = nil;
    [_networkHandler release];
    _networkHandler = nil;
    
    
    
    [super dealloc];
}
#pragma mark - Private Class Extensions


#pragma mark - Login&Register Requests
- (void)requestVerifyUsername:(NSString *)username
                      success:(void (^)(BOOL))sBlock
                         fail:(NetworkReqeustFailBlock)fBlock
{
    //temp
    if (sBlock)
    {
        sBlock(YES);
    }
}

- (void)requestRegisterWithUsername:(NSString *)username
                               type:(TMUserType)type
                            success:(void (^)(void))sBlock
                               fail:(NetworkReqeustFailBlock)fBlock
{
    if (sBlock)
    {
        sBlock();
    }
}

- (void)requestLoginWithUsername:(NSString *)username
                         success:(void (^)(void))sBlock
                            fail:(NetworkReqeustFailBlock)fBlock
{
    if (sBlock)
    {
        sBlock();
    }
}

#pragma mark - Avatar Request

- (void)requestAvatarWithURL:(NSURL *)url
                         uid:(NSString *)uid
                   timestamp:(NSString *)timestamp
                     success:(void (^)(UIImage *))sBlock
                        fail:(NetworkReqeustFailBlock)fBlock
{
    //push in concurrent queue
    dispatch_async(_facadeQueue, ^{
        
        //check cache sync in cache queue
        __block BOOL isLatest;
        __block UIImage* avatar = nil;
        
        //search cache
        dispatch_sync(_cacheQueue, ^{
            avatar = [_cacheHandler avatarWithUID:uid timestamp:timestamp isLatest:&isLatest];
        });
        
        //cached
        if (avatar)
        {
            //retain for main queue
            [avatar retain];
            //notify main queue
            dispatch_async(dispatch_get_main_queue(), ^{
                if(sBlock) sBlock([avatar autorelease]);
            });
        }
        //return when avatar is latest
        if(isLatest)
        {
            return;
        }
        //not cached
        else if(url)
        {
            [_networkHandler imageRequestWithURL:url success:^(UIImage *image) {
                //notify main queue
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (sBlock) sBlock(image);
                });
                //cache it
                dispatch_async(_cacheQueue, ^{
                    [_cacheHandler cacheAvatar:image uid:uid timestamp:timestamp];
                });
            } fail:^(NSError *error) {
                if (fBlock) fBlock(error);
            }];
        }
        
    });
    
}

@end
