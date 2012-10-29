
/*!
 * TMUserModel
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import <Foundation/Foundation.h>

typedef enum : NSUInteger{
    TMUserTypeEmail,
    TMUserTypeFacebook,
    TMUserTypeTwitter
}TMUserType;

@interface TMUserModel : NSObject

@property (nonatomic, copy) NSString* uid;

@property (nonatomic, copy) NSString* username;

@property (nonatomic, copy) NSString* nickname;

@property (nonatomic) TMUserType userType;

@property (nonatomic, retain) NSURL* avatarURL;

@property (nonatomic, copy) NSString* avatarTimestamp;


//shop
@property (nonatomic) NSUInteger coinNumber;
@property (nonatomic) NSUInteger propNumber;

+ (id)userModel;

@end
