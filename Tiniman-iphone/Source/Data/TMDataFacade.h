/*!
 * TMDataFacade
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import <Foundation/Foundation.h>

/*!
 * @class TMDataFacade
 * @abstract Facade of all data requests
 */
@interface TMDataFacade : NSObject

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

///-------------------------------------------------
/// @name Requests
///-------------------------------------------------

typedef void(^ReqeustFailBlock)(NSInteger errorCode);

//register
- (void)requestRegisterWithUsername:(NSString *)username type:(int)type;

//verify
- (void)requestVerifyUsername:(NSString *)username
                      success:(void(^)(BOOL hasRegistered))sBlock
                         fail:(ReqeustFailBlock)fBlock;

//login
- (void)requestLoginWithToken:(NSString *)token
                      success:(void(^)(void))sBlock
                         fail:(ReqeustFailBlock)fBlock;


/*!@abstract
 * request avatar image
 */
- (void)requestAvatarWithURL:(NSURL *)url
                         uid:(NSString *)uid
                   timestamp:(NSString *)timestamp
                     success:(void(^)(UIImage* avatarImage))sBlock
                        fail:(ReqeustFailBlock)fBlock;


@end
