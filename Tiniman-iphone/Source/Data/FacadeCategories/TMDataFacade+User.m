
#import "TMDataFacade+User.h"

@implementation TMDataFacade (SignIn)

- (void)requestVerifyUsername:(NSString *)username
                      success:(void (^)(BOOL))sBlock
                         fail:(NetworkReqeustFailBlock)fBlock
{
    //gen paramsDict
    NSDictionary* paramsDict = @{@"username" : username};
    
    [self.networkHandler httpRequestWithPath:@"/user/verify" method:@"POST" params:paramsDict success:^(NSDictionary *dataDict) {
        
        BOOL exist = [[dataDict objectForKey:@"exist"] boolValue];
        
        if (sBlock)
        {
            sBlock(exist);
        }
        
    } fail:^(NSError *error) {
        if (fBlock)
        {
            fBlock(error);
        }
        
    }];
    

}

- (void)requestRegisterWithUsername:(NSString *)username
                               type:(TMUserType)type
                            success:(void (^)(void))sBlock
                               fail:(NetworkReqeustFailBlock)fBlock
{
    NSParameterAssert(username);
    NSParameterAssert(type >= 0 && type <= 2);
    
    //user type mapping
    NSString* user_type = [TMUserModel stringFromUserType:type];
    
    //gen paramsDict
    NSDictionary* paramsDict = @{@"username":username,@"user_type":user_type};
    
    [self.networkHandler httpRequestWithPath:@"/user/register" method:@"POST" params:paramsDict success:^(NSDictionary *dataDict) {
        if (sBlock)
        {
            sBlock();
        }
    } fail:^(NSError *error) {
        if (fBlock)
        {
            fBlock(error);
        }}];
    

    
}

- (void)requestLoginWithUsername:(NSString *)username
                         success:(void (^)(TMUserModel *))sBlock
                            fail:(NetworkReqeustFailBlock)fBlock
{
    //gen paramsDict
    NSDictionary* paramsDict = @{@"username" : username};
    
    [self.networkHandler httpRequestWithPath:@"/user/login" method:@"POST" params:paramsDict success:^(NSDictionary* dataDict) {
        
        //create user model
        TMUserModel* user = [TMUserModel userModel];
        
        //set user data
        user.uid = [dataDict objectForKey:@"uid"];
        user.username = username;
        //user.userType = [[dataDict objectForKey:@"userType"] integerValue];
        user.nickname = [dataDict objectForKey:@"nickname"];
        
        user.avatarURL = [NSURL URLWithString:[dataDict objectForKey:@"avatar_url"]];
        user.avatarTimestamp = [dataDict objectForKey:@"avatar_timestamp"];
        
        user.coinNumber = [[dataDict objectForKey:@"coin_num"] integerValue];
        user.propNumber = [[dataDict objectForKey:@"prop_num"] integerValue];
        
        //set host user
        self.hostUser = user;
        
        if (sBlock)
        {
            sBlock(user);
        }
        
    } fail:^(NSError* error) {
        if (fBlock)
        {
            fBlock(error);
        }
    }];
    

}

@end