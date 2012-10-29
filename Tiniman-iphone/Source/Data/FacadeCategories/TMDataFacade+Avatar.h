
/*!
 * TMDataFacade+Avatar.h
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import "TMDataFacade.h"

@interface TMDataFacade (Avatar)


- (void)requestAvatarWithURL:(NSURL *)url
                         uid:(NSString *)uid
                   timestamp:(NSString *)timestamp
                     success:(void(^)(UIImage* avatarImage))sBlock
                        fail:(NetworkReqeustFailBlock)fBlock;


@end