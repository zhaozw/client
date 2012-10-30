
#import "TMDataFacade+SignIn.h"

@implementation TMDataFacade (SignIn)

- (void)requestVerifyUsername:(NSString *)username
                      success:(void (^)(BOOL))sBlock
                         fail:(NetworkReqeustFailBlock)fBlock
{
    //sync
    dispatch_sync(dispatch_get_main_queue(), ^{
        //gen paramsDict
        NSDictionary* paramsDict = @{@"username" : username};
        
        [self.networkHandler httpRequestWithPath:@"verify" method:@"POST" params:paramsDict success:^(NSDictionary *dataDict) {
            if (sBlock)
            {
                sBlock(YES);
            }
        } fail:^(NSError *error) {
            TMDataErrorLog(error);
            if (fBlock)
            {
                fBlock(error);
            }
            
        }];
    });

}

- (void)requestRegisterWithUsername:(NSString *)username
                               type:(TMUserType)type
                            success:(void (^)(void))sBlock
                               fail:(NetworkReqeustFailBlock)fBlock
{
    //sync
    dispatch_sync(dispatch_get_main_queue(), ^{
        //gen paramsDict
        NSDictionary* paramsDict = @{@"username" : username};
        
        [self.networkHandler httpRequestWithPath:@"verify" method:@"POST" params:paramsDict success:^(NSDictionary *dataDict) {
            if (sBlock)
            {
                sBlock();
            }
        } fail:^(NSError *error) {
            TMDataErrorLog(error);
            if (fBlock)
            {
                fBlock(error);
            }}];
    });

    
}

- (void)requestLoginWithUsername:(NSString *)username
                         success:(void (^)(TMUserModel *))sBlock
                            fail:(NetworkReqeustFailBlock)fBlock
{
    //sync
    //dispatch_sync(dispatch_get_main_queue(), ^{
        
        //gen paramsDict
        NSDictionary* dict = @{@"username" : username};
        
        [self.networkHandler httpRequestWithPath:@"login/email/123123" method:@"GET" params:nil success:^(NSDictionary* dataDict) {
            
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
            TMDataErrorLog(error);
            if (fBlock)
            {
                fBlock(error);
            }
        }];

   // });
}

@end
