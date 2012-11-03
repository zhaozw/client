//
//  TMShopViewController.h
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

typedef enum {
    TMShopTypeProp,
    TMShopTypeCoin
} TMShopType;

@class TMShopViewController;

@protocol TMShopViewControllerDelegate <NSObject>

- (void)shopDidExit:(TMShopViewController *)controller;

@end

@interface TMShopViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, unsafe_unretained) id<TMShopViewControllerDelegate> delegate;

@property (nonatomic, assign) TMShopType shopeType;

@end
