
/*!
 * TMNetworkHandler
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import <Foundation/Foundation.h>

@interface TMNetworkHandler : NSObject

typedef void(^NetworkReqeustFailBlock)(NSError* error);


- (void)imageRequestWithURL:(NSURL *)url
                    success:(void(^)(UIImage* image))sBlock
                       fail:(NetworkReqeustFailBlock)fBlock;


@end
