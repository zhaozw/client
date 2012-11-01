
/*!
 * TMDataFacade+User.h
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import "TMDataFacade.h"

@interface TMDataFacade (User)

//local cached last login username
- (NSString *)requestUsernameLastLogin;

//verify
- (void)requestVerifyUsername:(NSString *)username
                      success:(void(^)(BOOL hasRegistered))sBlock
                         fail:(TMDataRequestFailBlock)fBlock;

//register
- (void)requestRegisterWithUsername:(NSString *)username
                               type:(TMUserType)type
                            success:(void(^)(void))sBlock
                               fail:(TMDataRequestFailBlock)fBlock;

//login
- (void)requestLoginWithUsername:(NSString *)username
                         success:(void(^)(TMUserModel* user))sBlock
                            fail:(TMDataRequestFailBlock)fBlock;

//update nickname
- (void)requestUpdateNickname:(NSString *)nickname
                      success:(void(^)(void))sBlock
                         fail:(TMDataRequestFailBlock)fBlock;
@end

