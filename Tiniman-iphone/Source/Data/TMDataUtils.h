
/*!
 * TMDataUtils.h
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */



//macro defines
#define TMDataErrorLog(error) \
if([(error) isKindOfClass:[NSError class]])\
{\
    NSLog(@"TMDataErrorLog | %s", __PRETTY_FUNCTION__);\
    NSLog(@"TMDataErrorLog | error code:{%d} description:{%@}",(error).code, (error).localizedDescription);\
}

#define TMDataLocalHostURL [NSURL URLWithString:@"http://192.168.1.109:8000/"]
#define TMDataServerBaseURL TMDataLocalHostURL
/*
static void inline _TMDataErrorLog(NSError* error)
{
    if ([error isKindOfClass:[NSError class]])
    {
        NSLog(@"TMDataErrorLog | %s", __PRETTY_FUNCTION__);
        NSLog(@"TMDataErrorLog | error code:{%d} description:{%@}",(error).code, (error).localizedDescription);
    }
}
*/