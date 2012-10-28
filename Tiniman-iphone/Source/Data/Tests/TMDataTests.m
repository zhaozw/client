




#import "TMDataTests.h"

#import "TMDataFacade.h"

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
- (void)testLogin
{
    //发送验证请求、验证用户名是否注册过
    [_facade requestVerifyUsername:_username1 success:^(BOOL hasRegistered) {
        //注册的账号、可以登陆
        if (hasRegistered)
        {
            //发送登陆请求
            [_facade requestLoginWithUsername:_username1 success:^{
                NSLog(@"Login Succeed");
            } fail:^(NSInteger errorCode) {
                NSLog(@"Login | error code:%d", errorCode);
            }];
        }
        //未注册的账号、注册
        else
        {
            //发送注册请求(根据username来源选择userType)
            [_facade requestRegisterWithUsername:_username1 type:TMUserTypeEmail success:^{
                //注册成功、登陆
                //发送登陆请求
                [_facade requestLoginWithUsername:_username1 success:^{
                    NSLog(@"Login Succeed");
                } fail:^(NSInteger errorCode) {
                    NSLog(@"Login | error code:%d", errorCode);
                }];
            } fail:^(NSInteger errorCode) {
                NSLog(@"Register | error code:%d", errorCode);
            }];
        }
        
    } fail:^(NSInteger errorCode) {
        NSLog(@"Verifty username | error code:%d", errorCode);
    }];
}









@end
