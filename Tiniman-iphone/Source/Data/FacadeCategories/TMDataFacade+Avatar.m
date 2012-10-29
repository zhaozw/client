

#import "TMDataFacade+Avatar.h"

@implementation TMDataFacade (Avatar)

- (void)requestAvatarWithURL:(NSURL *)url
                         uid:(NSString *)uid
                   timestamp:(NSString *)timestamp
                     success:(void (^)(UIImage *))sBlock
                        fail:(NetworkReqeustFailBlock)fBlock
{
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
                if(sBlock) sBlock([avatar autorelease]);
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
                    if (sBlock) sBlock(image);
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
