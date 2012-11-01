

#import "TMDataTests.h"

#import "TMData.h"

@implementation TMDataTests
{
    TMDataFacade* _facade;
    
    NSString* _username1;
}

+ (id)tests
{
    static TMDataTests* tests;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tests = [[TMDataTests alloc] init];
    });
    return tests;
}

- (id)init
{
    self = [super init];
    
    _facade = [TMDataFacade facade];
    _username1 = [@"username1@gmail.com" retain];
    
    return self;
}

- (void)beginTests
{
    //test avatar
    //    [[TMDataTests tests] testAvatar];
    
    //test login
    //[[TMDataTests tests] testLogin];
    
    //    [[TMDataTests tests] testHttpReqeust];
    
    //[[TMDataTests tests] testUserInfo];
    
    //[[TMDataTests tests] testErrorDescription];
    
    //shop
    //[self testShopList];
    
    //[self testUpdateNickname];
}



- (void)testAvatar
{
    //测试数据
    NSURL* url = [NSURL URLWithString:@"http://tp4.sinaimg.cn/1706244847/180/5644246534/0"];
    //NSURL* url2 = [NSURL URLWithString:@"http://tp2.sinaimg.cn/1667982173/50/5645713134/0"];
    NSString* uid = @"uid1213123";
    NSString* timestamp = @"21012121029";
    
    [_facade requestAvatarWithURL:url uid:uid timestamp:timestamp success:^(UIImage *avatarImage, BOOL isLastest) {
        NSLog(@"is lastest:%d", isLastest);
        NSLog(@"image size:%@", NSStringFromCGSize(avatarImage.size));
    } fail:^(NSError *error) {
        NSLog(@"error:%@", error);
    }];
}

- (void)testUserInfo
{
    [_facade.cacheHandler cacheUsernameLastLogin:@"123123"];
    NSLog(@"last login:%@", [_facade requestUsernameLastLogin]);
    
    
}

- (void)testErrorDescription
{
    
    
}



- (void)testVerify
{
    [_facade requestVerifyUsername:_username1 success:^(BOOL hasRegistered) {
        NSLog(@"%d", hasRegistered);
    } fail:^(NSError *error) {
        TMDataErrorLog(error);
    }];
}

- (void)testRegister
{
    [_facade requestRegisterWithUsername:_username1 type:TMUserTypeEmail success:^{
        NSLog(@"register success");
    } fail:^(NSError *error) {
        TMDataErrorLog(error);
    }];
}

- (void)testLogin
{
    [_facade requestLoginWithUsername:@"sunny" success:^(TMUserModel *user) {
        NSLog(@"login success");
        NSLog(@"%@", [_facade hostUser]);
        NSLog(@"token:%@", _facade.token);
    } fail:^(NSError *error) {
        TMDataErrorLog(error);
    }];

}

- (void)testUpdateNickname
{
    [_facade requestLoginWithUsername:@"sunny" success:^(TMUserModel *user) {
        [_facade requestUpdateNickname:@"2b2b2b2b" success:^{
            NSLog(@"update nickname success");
        } fail:^(NSError *error) {
            TMDataErrorLog(error);
        }];
    } fail:nil];

}


- (void)testShopList
{
    [_facade requestLoginWithUsername:@"sunny" success:^(TMUserModel *user) {
        [_facade requestShopListWithSuccessBlock:^(TMShopModel *shopModel) {
            NSLog(@"coin:%@", shopModel.coinPackages);
            NSLog(@"prop:%@", shopModel.propPackages);
        } fail:^(NSError *error) {
            TMDataErrorLog(error);
        }];
    } fail:nil];
    

}






@end