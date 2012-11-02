
/*!
 * TMDataFacade+Shop.h
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import "TMDataFacade.h"

@interface TMDataFacade (Shop)

- (void)requestShopListWithSuccessBlock:(void(^)(TMShopModel* shopModel))sBlock
                                   fail:(TMDataRequestFailBlock)fBlock;

- (void)requestBuyPropWithPropPackageID:(NSString *)propPackageID
                                success:(void(^)(TMUserModel* userModel))sBlock
                                   fail:(TMDataRequestFailBlock)fBlock;

@end
