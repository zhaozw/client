
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
    NSArray* mapping = @[@"email", @"facebook", @"twitter"];
    return mapping[type];
}

+ (TMUserType)userTypeFromString:(NSString *)string
{
    NSArray* mapping = @[@"email", @"facebook", @"twitter"];
    return (TMUserType)[mapping indexOfObject:string];
}

@end
