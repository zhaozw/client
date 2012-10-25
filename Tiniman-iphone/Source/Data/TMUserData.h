/*!
 * TMUserData.h
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import <Foundation/Foundation.h>

/*!
 * @class TMUserData
 * @abstract store all data of a certain user
 */
@interface TMUserData : NSObject

/*!
 * @property uid
 * @abstract unique user id
 */
@property (nonatomic, copy) NSString* uid;

/*!
 * @property username
 * @abstract email or facebook/twitter username
 */
@property (nonatomic, copy) NSString* username;

/*!
 * @property nickname
 * @abstract nickname showed in game
 */
@property (nonatomic, copy) NSString* nickname;

/*!
 * @property avatarURL
 * @abstract the url of avatar(local cache/cloud)
 */
@property (nonatomic, copy) NSURL* avatarURL;

@end
