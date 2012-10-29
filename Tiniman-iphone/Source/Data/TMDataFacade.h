/*!
 * TMDataFacade
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import <Foundation/Foundation.h>

#import "TMUserModel.h"

//handlers
#import "TMCacheHandler.h"
#import "TMNetworkHandler.h"

/*!
 * @class TMDataFacade
 * @abstract Facade of all data requests
 */
@interface TMDataFacade : NSObject

@property (nonatomic, readonly) dispatch_queue_t facadeQueue;
@property (nonatomic, readonly) dispatch_queue_t cacheQueue;
@property (nonatomic, readonly) TMCacheHandler* cacheHandler;
@property (nonatomic, readonly) TMNetworkHandler* networkHandler;

//singleton
+ (id)facade;
+ (void)unload;


@end

