

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
    } fail:^(NSError *error) {
        TMDataErrorLog(error);
    }];
//    
//    //发送验证请求、验证用户名是否注册过
//    [_facade requestVerifyUsername:_username1 success:^(BOOL hasRegistered) {
//        //注册的账号、可以登陆
//        if (hasRegistered)
//        {
//            //发送登陆请求
//            [_facade requestLoginWithUsername:_username1 success:^(TMUserModel* user){
//                NSLog(@"Login Succeed");
//            } fail:^(NSError *error) {
//                TMDataErrorLog(error);
//                NSLog(@"login error:%@", error);
//            }];
//        }
//        //未注册的账号、注册
//        else
//        {
//            //发送注册请求(根据username来源选择userType)
//            [_facade requestRegisterWithUsername:_username1 type:TMUserTypeEmail success:^{
//                //注册成功、登陆
//                //发送登陆请求
//                [_facade requestLoginWithUsername:_username1 success:^(TMUserModel* user){
//                    NSLog(@"Login Succeed");
//                } fail:^(NSError *error) {
//                    NSLog(@"login:error:%@", error);
//                }];
//            } fail:^(NSError *error) {
//                NSLog(@"register error:%@", error);
//            }];
//        }
//        
//    } fail:^(NSError *error) {
//        NSLog(@"verify error:%@", error);
//    }];
}

- (void)testHttpReqeust
{
    TMNetworkHandler* handler = [[TMNetworkHandler alloc] initWithServerBaseURL:TMDataLocalHostURL];
    
    [handler httpRequestWithPath:@"login/email/123123" method:@"GET" params:nil success:^(NSDictionary *dataDict) {
        NSLog(@"dataDict:%@", dataDict);
    } fail:^(NSError *error) {
        TMDataErrorLog(error);
    }];
    
}







@end