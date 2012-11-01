
/*!
 * TMShopModel.h
 * Tiniman-iphone
 * @author sunny
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import <Foundation/Foundation.h>


@interface TMShopPropPackageModel : NSObject

//id
@property (nonatomic, copy) NSString* propPackageID;
//prop bag name, like:"flag bag #1"
@property (nonatomic, copy) NSString* propPackageName;
//number of prop bag
@property (nonatomic) NSUInteger propNumber;
//cost of prop bag(coins)
@property (nonatomic) NSUInteger propPackagePriceOfCoin;
//description
@property (nonatomic, copy) NSString* propPackageInfo;

+ (id)propPackageModel;

@end

@interface TMShopCoinPackageModel : NSObject

//id
@property (nonatomic, copy) NSString* coinPackageID;
//name
@property (nonatomic, copy) NSString* coinPackageName;
//number
@property (nonatomic) NSUInteger coinNumber;
//price, like 1.99
@property (nonatomic) NSUInteger coinPackagePriceOfMoney;
//description
@property (nonatomic, copy) NSString* coinPackageInfo;

+(id)coinPackageModel;

@end

@interface TMShopModel : NSObject

//list of prop package,contains TMShopPropPackageModel Objects
@property (nonatomic, retain) NSArray* propPackages;
//list of coin package,contains TMShopCoinPackageModel Objects
@property (nonatomic, retain) NSArray* coinPackages;

+ (id)shopModel;

@end
