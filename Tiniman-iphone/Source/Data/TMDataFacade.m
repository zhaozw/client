
#import "TMDataFacade.h"


@interface TMDataFacade ()
{
    
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

@end
