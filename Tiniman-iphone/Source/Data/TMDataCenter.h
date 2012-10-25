/*!
 * TMDataCenter.h
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import "TMDataRequest.h"

/*!
 * @typedef TMRequestOption
 * @abstract <#abstract#>
 * @field TMRequestOptionSync sync request
 * @field TMRequestOptionAsync async request
 */
typedef enum : NSUInteger{
    TMRequestOptionSync = 1 << 0,
    TMRequestOptionAsync = 1 << 1,
    
    TMRequestOptionConcurrent = 1 << 2,
    TMRequestOptionSerial = 1 << 3
}TMRequestOption;

/*!
 * @class TMDataCenter
 * @abstract Singleton shared data entrance
 */
@interface TMDataCenter : NSObject{
    
}

/*singleton*/

/*!
 * @method center
 * @abstract lazy load singleton,using dispatch_once
 */
+ (id)center;

/*!
 * @method unload
 * @abstract unload singleton
 */
+ (void)unload;

/*data request*/

- (void)sendRequest:(TMDataRequest *)request options:(TMRequestOption)option;

@end
