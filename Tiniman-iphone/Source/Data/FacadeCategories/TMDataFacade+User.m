
#import "TMDataFacade+User.h"

@implementation TMDataFacade (SignIn)

- (NSString *)requestUsernameLastLogin
{
    __block NSString* username = nil;
    dispatch_sync(self.cacheQueue, ^{
        username = [self.cacheHandler usernameLastLogin];
    });
    return username;
}

- (void)requestVerifyUsername:(NSString *)username
                      success:(void (^)(BOOL))sBlock
                         fail:(TMDataRequestFailBlock)fBlock
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
                               fail:(TMDataRequestFailBlock)fBlock
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
                            fail:(TMDataRequestFailBlock)fBlock
{
    //gen paramsDict
    NSDictionary* paramsDict = @{@"username" : username};
    
    [self.networkHandler httpRequestWithPath:@"/user/login" method:@"POST" params:paramsDict success:^(NSDictionary* dataDict) {
        
        //create user model
        TMUserModel* user = [TMUserModel userModel];
        
        //set user data
        user.uid = [dataDict objectForKey:@"uid"];
        user.username = username;
        user.userType = [TMUserModel userTypeFromString:[dataDict objectForKey:@"userType"]];
        user.nickname = [dataDict objectForKey:@"nickname"];
        
        user.avatarURL = [NSURL URLWithString:[dataDict objectForKey:@"avatar_url"]];
        user.avatarTimestamp = [dataDict objectForKey:@"avatar_timestamp"];
        
        user.coinNumber = [[dataDict objectForKey:@"coin_num"] integerValue];
        user.propNumber = [[dataDict objectForKey:@"prop_num"] integerValue];
        
        //set host user in memory
        self.hostUser = user;
        
        //save token in memory
        self.token = [dataDict objectForKey:@"token"];
        
        //cache the username for next login
        dispatch_sync(self.cacheQueue, ^{
            [self.cacheHandler cacheUsernameLastLogin:username];
        });
        
        //notify
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
