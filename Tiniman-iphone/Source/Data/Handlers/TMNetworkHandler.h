
/*!
 * TMNetworkHandler
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import <Foundation/Foundation.h>

@interface TMNetworkHandler : NSObject

typedef void(^NetworkRequestSuccessBlock)(NSDictionary* dataDict);
typedef void(^NetworkReqeustFailBlock)(NSError* error);

@property (nonatomic, copy) NSURL* baseURL;

- (void)imageRequestWithURL:(NSURL *)url
                    success:(void(^)(UIImage* image))sBlock
                       fail:(NetworkReqeustFailBlock)fBlock;

- (void)httpRequestWithPath:(NSString *)path
                     method:(NSString *)method
                     params:(NSDictionary *)paramsDict
                    success:(NetworkRequestSuccessBlock)sBlock
                       fail:(NetworkReqeustFailBlock)fBlock;


@end
