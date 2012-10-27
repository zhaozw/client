/*!
 * TMDataFacade
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import <Foundation/Foundation.h>


/*!
 * @typedef TMRequestOption
 * @abstract <#abstract#>
 * @field TMRequestOptionSync sync request
 * @field TMRequestOptionAsync async request
 */
typedef enum : NSUInteger{
    TMDispatchOptionSync = 1 << 0,
    TMDispatchOptionAsyncSerial = 1 << 1,
    
    TMDispatchOptionAsyncConcurrent = 1 << 2
    
    
}TMDispatchOption;


/*!
 * @class TMDataFacade
 * @abstract Facade of all data requests
 */
@interface TMDataFacade : NSObject

///-------------------------------------------------
/// @name TMDataFacade Singleton
///-------------------------------------------------

/*!
 * @method facade
 * @abstract lazy load singleton,using dispatch_once
 */
+ (id)facade;

/*!
 * @method unload
 * @abstract unload singleton
 */
+ (void)unload;

///-------------------------------------------------
/// @name Requests
///-------------------------------------------------


- (void)requestAvatarWithURL:(NSURL *)url
                         uid:(NSString *)uid
                   timestamp:(NSString *)timestamp
                     success:(void(^)(UIImage* avatarImage))sBlock
                        fail:(void(^)(NSInteger error))fBlock;


@end
