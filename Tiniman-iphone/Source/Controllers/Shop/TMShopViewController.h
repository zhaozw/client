//
//  TMShopViewController.h
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import <UIKit/UIKit.h>

@class TMShopViewController;

@protocol TMShopViewControllerDelegate <NSObject>

- (void)shopDidExit:(TMShopViewController *)controller;

@end

@interface TMShopViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, unsafe_unretained) id<TMShopViewControllerDelegate> delegate;

@property (retain, nonatomic) IBOutlet UIButton *flipButton;

@end
