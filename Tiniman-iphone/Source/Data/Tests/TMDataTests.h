
/*!
 * TMDataTests
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import <Foundation/Foundation.h>

@interface TMDataTests : NSObject

+ (id)tests;

- (void)beginTests;

- (void)testAvatar;
- (void)testUserInfo;
- (void)testErrorDescription;

///user
- (void)testVerify;
- (void)testRegister;
- (void)testLogin;
- (void)testUpdateNickname;
- (void)testUpdateAvatar;

//shop
- (void)testShopList;


@end
