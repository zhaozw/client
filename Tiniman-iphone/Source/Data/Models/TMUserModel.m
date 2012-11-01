
#import "TMUserModel.h"

@implementation TMUserModel

+ (id)userModel
{
    return [[[TMUserModel alloc] init] autorelease];
}

- (NSString *)description
{
    return [NSString stringWithFormat:
            @"<%@:%p>{\n uid:\"%@\"\n username:\"%@\" \n nickname:\"%@\" \n user_type:\"%@\" \n}",
            NSStringFromClass(self.class),
            self,
            self.uid,
            self.username,
            self.nickname,
            [TMUserModel stringFromUserType:self.userType]
            
            ];
}

+ (NSString *)stringFromUserType:(TMUserType)type
{
    if (type == TMUserTypeEmail || type == TMUserTypeFacebook || type == TMUserTypeTwitter)
    {
        NSArray* mapping = @[@"email", @"facebook", @"twitter"];
        return mapping[type];
    }
    return @"email";

}

+ (TMUserType)userTypeFromString:(NSString *)string
{
    NSArray* mapping = @[@"email", @"facebook", @"twitter"];
    if (!string)
    {
        return TMUserTypeEmail;
    }
    return (TMUserType)[mapping indexOfObject:string];
}

@end
