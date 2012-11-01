
#import "TMDataFacade+Shop.h"

@implementation TMDataFacade (Shop)

- (void)requestShopListWithSuccessBlock:(void (^)(TMShopModel *))sBlock fail:(TMDataRequestFailBlock)fBlock
{
    
    NSDictionary* paramDict = @{@"token":self.token};
    
    [self.networkHandler httpRequestWithPath:@"shop/list" method:@"POST" params:paramDict success:^(NSDictionary *dataDict) {
        //parse data
        
        NSMutableArray* coinPackages = [NSMutableArray array];
        
        for (NSDictionary* dict in [dataDict objectForKey:@"coin_packages"])
        {
            TMShopCoinPackageModel* coinPackage = [TMShopCoinPackageModel coinPackageModel];
            
            coinPackage.coinPackageID = [dict objectForKey:@"id"];
            coinPackage.coinPackageInfo = [dict objectForKey:@"info"];
            coinPackage.coinPackageName = [dict objectForKey:@"name"];
            coinPackage.coinNumber = [[dict objectForKey:@"number"] integerValue];
            coinPackage.coinPackagePriceOfMoney = [[dict objectForKey:@"price"] integerValue];
            
            [coinPackages addObject:coinPackage];
        }
        
        NSMutableArray* propPackages = [NSMutableArray array];
        
        for (NSDictionary* dict in [dataDict objectForKey:@"coin_packages"])
        {
            TMShopPropPackageModel* propPackage = [TMShopPropPackageModel propPackageModel];
            
            propPackage.propPackageID = [dict objectForKey:@"id"];
            propPackage.propPackageInfo = [dict objectForKey:@"info"];
            propPackage.propPackageName = [dict objectForKey:@"name"];
            propPackage.propNumber = [[dict objectForKey:@"number"] integerValue];
            propPackage.propPackagePriceOfCoin = [[dict objectForKey:@"price"] integerValue];
            
            [propPackages addObject:propPackage];
        }
        
        
        TMShopModel* shopModel = [TMShopModel shopModel];
        shopModel.propPackages = propPackages;
        shopModel.coinPackages = coinPackages;
        
        if (sBlock)
        {
            sBlock(shopModel);
        }
        
    } fail:^(NSError *error) {
        if (fBlock)
        {
            fBlock(error);
        }
    }];
}
@end
