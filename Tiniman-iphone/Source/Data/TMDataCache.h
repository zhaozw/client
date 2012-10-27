
/*!
 * TMDataCache.h
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import <Foundation/Foundation.h>

/*!
 * @class TMDataCache
 * @abstract handle local cache,
 * avatar images | user local data
 */
@interface TMDataCache : NSObject

///----------------------------
///@name avatar image cache
///----------------------------

- (UIImage *)avatarWithUID:(NSString *)uid timestamp:(NSString *)timestamp isLatest:(BOOL *)isLatest;

- (void)cacheAvatar:(UIImage *)avatar uid:(NSString *)uid timestamp:(NSString *)timestamp;

///----------------------------
///@name user local data
///----------------------------


@end
