
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

#define TMDataLocalHostURL [NSURL URLWithString:@"http://127.0.0.1:8000/"]
//#define TMDataLocalHostURL [NSURL URLWithString:@"http://192.168.1.108:8000/"]

#define TMDataServerBaseURL TMDataLocalHostURL


//type defines
typedef void(^TMDataRequestFailBlock)(NSError* error);
typedef void(^TMDataNetworkSuccessBlock)(NSDictionary* dataDict);
