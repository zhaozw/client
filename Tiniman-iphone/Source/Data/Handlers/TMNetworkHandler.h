
/*!
 * TMNetworkHandler
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import <Foundation/Foundation.h>

#import "TMDataUtils.h"

@interface TMNetworkHandler : NSObject


- (id)initWithServerBaseURL:(NSURL *)baseURL;

- (void)imageRequestWithURL:(NSURL *)url
                    success:(void(^)(UIImage* image))sBlock
                       fail:(TMDataRequestFailBlock)fBlock;

- (void)httpRequestWithPath:(NSString *)path
                     method:(NSString *)method
                     params:(NSDictionary *)paramsDict
                    success:(TMDataNetworkSuccessBlock)sBlock
                       fail:(TMDataRequestFailBlock)fBlock;


@end
