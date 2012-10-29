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

///-------------------------------------------------
/// @name TMDataFacade Singleton
///-------------------------------------------------

/*!@abstract 
 * lazy load singleton,using dispatch_once
 */
+ (id)facade;

/*!@abstract 
 * unload singleton
 */
+ (void)unload;

///-------------------------------------------------
/// @name Fetches
///-------------------------------------------------

//login&request
- (NSString *)fetchLoginToken;
@end
///-------------------------------------------------
/// @name Requests
///-------------------------------------------------
@interface TMDataFacade (SignIn)
//register
- (void)requestRegisterWithUsername:(NSString *)username
                               type:(TMUserType)type
                            success:(void(^)(void))sBlock
                               fail:(NetworkReqeustFailBlock)fBlock;

//verify
- (void)requestVerifyUsername:(NSString *)username
                      success:(void(^)(BOOL hasRegistered))sBlock
                         fail:(NetworkReqeustFailBlock)fBlock;

//login
- (void)requestLoginWithUsername:(NSString *)username
                         success:(void(^)(TMUserModel* user))sBlock
                            fail:(NetworkReqeustFailBlock)fBlock;

@end


@interface TMDataFacade (Avatar)
/*!@abstract
 * request avatar image
 */
- (void)requestAvatarWithURL:(NSURL *)url
                         uid:(NSString *)uid
                   timestamp:(NSString *)timestamp
                     success:(void(^)(UIImage* avatarImage))sBlock
                        fail:(NetworkReqeustFailBlock)fBlock;


@end
