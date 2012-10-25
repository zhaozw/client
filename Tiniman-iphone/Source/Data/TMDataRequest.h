/*!
 * TMDataRequest.h
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */


/*!
 * @class TMDataRequest
 * @abstract
 */
@interface TMDataRequest : NSObject

/*!
 * @property errorBlock
 * @abstract (OPTIONAL)the error handler block
 * execute just when there is a error during request
 * @discussion
 * if this property is not set,it will never execute
 * can also get 'error code' though dataBlock
 */
@property (nonatomic, copy) void(^errorBlock)(NSUInteger errorCode);

/*!
 * @property dataBlock
 * @abstract the data process block
 * execute when no errors
 * @discussion
 * a common type(id) to JUST STORE different kind of precess blocks
 * actually transform to void(^)(NSUInteger errorCode, ...) to execute
 */
@property (nonatomic, copy) void(^dataBlock)(NSUInteger error, ...);

/*!
 * @property parseBlock
 * @abstract the block to parse certain data on certain dictionary
 * @discussion
 * a common type(id) to JUST STORE different kind of precess blocks
 * actually transform to void(^)(NSUInteger errorCode, ...) to execute
 */

@property (nonatomic, copy) void(^parseBlock)(NSDictionary *);
/*!
 * @method request
 * @abstract create an autorelease TMDataRequest object
 */
+ (id)request;

@end


@interface TMDataRequest (NetDataRequestFactory)
+ (id)NetRequestLoginWithUsername:(NSString *)username dataBlock:(void(^)(NSUInteger error, NSString* nickname))dataBlock;
@end