

#import "TMDataFacade+Avatar.h"

@implementation TMDataFacade (Avatar)

- (void)requestUpdateAvatar:(UIImage *)avatarImage
                    success:(void (^)(void))sBlock
                       fail:(TMDataRequestFailBlock)fBlock
{
    NSParameterAssert(avatarImage);
    NSParameterAssert(self.token);
    NSParameterAssert(self.hostUser);
    
    //push in concurrent queue
    dispatch_async(self.facadeQueue, ^{
        
        //avatar image data
        NSData* data = UIImagePNGRepresentation(avatarImage);
        
        NSDictionary* paramDict = @{@"token":self.token, @"avatar":data};
        
        [self.networkHandler httpRequestWithPath:@"/user/update_avatar" method:@"POST" params:paramDict success:^(NSDictionary *dataDict) {
            
            //get new timestamp
            NSURL* url = [NSURL URLWithString:[dataDict objectForKey:@"url"]];
            NSString* timestamp = [dataDict objectForKey:@"timestamp"];
            
            //cache it
            [self.cacheHandler cacheAvatar:avatarImage uid:self.hostUser.uid timestamp:timestamp];
            
            //update memory
            self.hostUser.avatarURL = url;
            self.hostUser.avatarTimestamp = timestamp;
            
            //notify
            if (sBlock)
            {
                sBlock();
            }
            
        } fail:^(NSError *error) {
            if (fBlock)
            {
                fBlock(error);
            }
        }];
        
    });
}




- (void)requestAvatarWithURL:(NSURL *)url
                         uid:(NSString *)uid
                   timestamp:(NSString *)timestamp
                     success:(void (^)(UIImage *, BOOL))sBlock
                        fail:(TMDataRequestFailBlock)fBlock
{
    NSParameterAssert(url && uid && timestamp);
    
    //push in concurrent queue
    dispatch_async(self.facadeQueue, ^{
        
        //check cache sync in cache queue
        __block BOOL isLatest;
        __block UIImage* avatar = nil;
        
        //search cache
        dispatch_sync(self.cacheQueue, ^{
            avatar = [self.cacheHandler avatarWithUID:uid timestamp:timestamp isLatest:&isLatest];
        });
        
        //cached
        if (avatar)
        {
            //retain for main queue
            [avatar retain];
            //notify main queue
            dispatch_async(dispatch_get_main_queue(), ^{
                if(sBlock) sBlock([avatar autorelease], isLatest);
            });
        }
        //return when avatar is latest
        if(isLatest)
        {
            return;
        }
        //not cached
        else if(url)
        {
            [self.networkHandler imageRequestWithURL:url success:^(UIImage *image) {
                //notify main queue
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (sBlock) sBlock(image, YES);
                });
                //cache it
                dispatch_async(self.cacheQueue, ^{
                    [self.cacheHandler cacheAvatar:image uid:uid timestamp:timestamp];
                });
            } fail:^(NSError *error) {
                if (fBlock) fBlock(error);
            }];
        }
        
    });
    
}


@end
