
/*!
 * TMDataFacade+User.h
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import "TMDataFacade.h"

@interface TMDataFacade (User)

//verify
- (void)requestVerifyUsername:(NSString *)username
                      success:(void(^)(BOOL hasRegistered))sBlock
                         fail:(NetworkReqeustFailBlock)fBlock;

//register
- (void)requestRegisterWithUsername:(NSString *)username
                               type:(TMUserType)type
                            success:(void(^)(void))sBlock
                               fail:(NetworkReqeustFailBlock)fBlock;

//login
- (void)requestLoginWithUsername:(NSString *)username
                         success:(void(^)(TMUserModel* user))sBlock
                            fail:(NetworkReqeustFailBlock)fBlock;

@end

