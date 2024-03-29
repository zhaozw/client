/*!
 * TMDataFacade
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import <Foundation/Foundation.h>

//utils
#import "TMDataUtils.h"

//models
#import "TMUserModel.h"
#import "TMShopModel.h"

//handlers
#import "TMCacheHandler.h"
#import "TMNetworkHandler.h"

/*!
 * @class TMDataFacade
 * @abstract Facade of all data
 */
@interface TMDataFacade : NSObject

@property (nonatomic, readonly) dispatch_queue_t facadeQueue;
@property (nonatomic, readonly) dispatch_queue_t cacheQueue;
@property (nonatomic, readonly) TMCacheHandler* cacheHandler;
@property (nonatomic, readonly) TMNetworkHandler* networkHandler;

//store host user's info
@property (nonatomic, retain) TMUserModel* hostUser;
@property (nonatomic, copy) NSString* token;


//singleton
+ (id)facade;
+ (void)unload;


@end

