
#import "TMDataFacade+SignIn.h"

@implementation TMDataFacade (SignIn)

- (void)requestVerifyUsername:(NSString *)username
                      success:(void (^)(BOOL))sBlock
                         fail:(NetworkReqeustFailBlock)fBlock
{
    if (sBlock)
    {
        sBlock(YES);
    }
}

- (void)requestRegisterWithUsername:(NSString *)username
                               type:(TMUserType)type
                            success:(void (^)(void))sBlock
                               fail:(NetworkReqeustFailBlock)fBlock
{
    if (sBlock)
    {
        sBlock();
    }
}

- (void)requestLoginWithUsername:(NSString *)username
                         success:(void (^)(TMUserModel *))sBlock
                            fail:(NetworkReqeustFailBlock)fBlock
{
    NSDictionary* dict = @{@"username" : username};
    
    [self.networkHandler httpRequestWithPath:@"login" method:@"POST" params:dict success:^(NSDictionary *dataDict) {
        
        //create user model
        TMUserModel* user = [TMUserModel userModel];
        
        //set user
        user.uid = [dataDict objectForKey:@"uid"];
        
        
        if (sBlock)
        {
            sBlock(user);
        }
        
    } fail:^(NSError *error) {
        if (fBlock)
        {
            fBlock(error);
        }
    }];
    
    

}


@end
