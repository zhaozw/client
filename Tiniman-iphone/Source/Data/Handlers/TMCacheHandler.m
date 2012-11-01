

#import "TMCacheHandler.h"

@interface TMCacheHandler ()
{
    
}

- (NSString *)avatarFileNameWithUID:(NSString *)uid;

- (void)createUserInfoPathsIfNotExist;
- (NSDictionary *)userInfoDict;

@end

@implementation TMCacheHandler

#define AvatarCacheDirectory [NSHomeDirectory() stringByAppendingFormat:@"/Documents/avatars/"]
#define UserInfoCacheDirectory [NSHomeDirectory() stringByAppendingFormat:@"/Documents/userInfo/"]
#define UserInfoFullPath [UserInfoCacheDirectory stringByAppendingFormat:@"userInfo.plist"]



#pragma mark - Avatar Cache

- (UIImage *)avatarWithUID:(NSString *)uid timestamp:(NSString *)timestamp isLatest:(BOOL *)isLatest
{
    //get avatar file name with uid
    NSString* avatarFileName = [self avatarFileNameWithUID:uid];
    
    //not found
    if (!avatarFileName)
    {
        *isLatest = NO;
        return nil;
    }
    
    //found
    else
    {
        //compare timestamp
        NSArray* parts = [avatarFileName componentsSeparatedByString:@"_"];
        //get timestamp from file name
        if ([[parts lastObject] isEqualToString:timestamp])
        {
            *isLatest = YES;
        }
        else
        {
            *isLatest = NO;
        }
        
        //full path
        NSString* fullPath = [AvatarCacheDirectory stringByAppendingPathComponent:avatarFileName];
        
        //get data
        NSData* data = [[NSFileManager defaultManager] contentsAtPath:fullPath];
        
        //load data failed
        if (!data)
        {
            return nil;
        }
        
        //success, create image
        else
        {
            return [UIImage imageWithData:data];
        }
        
    }
    
}

- (void)cacheAvatar:(UIImage *)avatar uid:(NSString *)uid timestamp:(NSString *)timestamp
{
    //file manager singleton
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    //create the avatar path if not exist
    if (![fileManager fileExistsAtPath:AvatarCacheDirectory])
    {
        [fileManager createDirectoryAtPath:AvatarCacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //check original avatar file with same uid
    NSString* originalAvatarFileName = [self avatarFileNameWithUID:uid];
    
    //remove original
    if (originalAvatarFileName)
    {
        NSString* originalAvatarFullPath = [AvatarCacheDirectory stringByAppendingPathComponent:originalAvatarFileName];
        [fileManager removeItemAtPath:originalAvatarFullPath error:nil];
    }
    
    //generate new full path
    NSString* newAvatarFullPath = [AvatarCacheDirectory stringByAppendingFormat:@"%@_%@", uid, timestamp];
    
    //jpeg data from avatar image cache
    //NSData* data = UIImageJPEGRepresentation(avatar, 1.0f);
    //png data from avatar image cache
    NSData* data = UIImagePNGRepresentation(avatar);
    
    //write avatar data to file
    [data writeToFile:newAvatarFullPath atomically:YES];
    
}

#pragma mark - UserInfo Cache

- (NSString *)usernameLastLogin
{
    return [[self userInfoDict] objectForKey:@"username"];
}

- (void)cacheUsernameLastLogin:(NSString *)username
{
    [self createUserInfoPathsIfNotExist];
    
    NSMutableDictionary* userInfoDict = [NSMutableDictionary dictionaryWithDictionary:[self userInfoDict]];
    
    [userInfoDict setValue:username forKey:@"username"];
    
    [userInfoDict writeToFile:UserInfoFullPath atomically:YES];
}



#pragma mark - Private

- (NSString *)avatarFileNameWithUID:(NSString *)uid
{
    //file manager singleton
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    //get all files in avatar directory
    NSArray* fileNames = [fileManager contentsOfDirectoryAtPath:AvatarCacheDirectory error:nil];
    
    //search avatar file path by uid
    NSString* avatarFileName = nil;
    for (NSString* fileName in fileNames)
    {
        if ([fileName rangeOfString:uid].length > 0)
        {
            avatarFileName = fileName;
            break;
        }
    }
    
    return avatarFileName;
}

- (void)createUserInfoPathsIfNotExist
{
    //file manager singleton
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    //create directory if not exist
    if (![fileManager fileExistsAtPath:UserInfoCacheDirectory])
    {
        [fileManager createDirectoryAtPath:UserInfoCacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //create userInfo.plist if not exist
    if (![fileManager fileExistsAtPath:UserInfoFullPath])
    {
        NSDictionary* dict = @{};
        [dict writeToFile:UserInfoFullPath atomically:YES];
    }
}


- (NSDictionary *)userInfoDict
{
    //file manager singleton
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:UserInfoFullPath])
    {
        NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:UserInfoFullPath];
        return dict;
    }
    else
    {
        return nil;
    }
}

#pragma mark - Dealloc

- (void)dealloc
{
    
    [super dealloc];
}
@end
