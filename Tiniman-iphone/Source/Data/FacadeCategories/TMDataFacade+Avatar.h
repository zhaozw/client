
/*!
 * TMDataFacade+Avatar.h
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import "TMDataFacade.h"

@interface TMDataFacade (Avatar)

- (void)requestUpdateAvatar:(UIImage *)avatarImage
                    success:(void(^)(void))sBlock
                       fail:(TMDataRequestFailBlock)fBlock;

- (void)requestAvatarWithURL:(NSURL *)url
                         uid:(NSString *)uid
                   timestamp:(NSString *)timestamp
                     success:(void(^)(UIImage* avatarImage, BOOL isLastest))sBlock
                        fail:(TMDataRequestFailBlock)fBlock;


@end