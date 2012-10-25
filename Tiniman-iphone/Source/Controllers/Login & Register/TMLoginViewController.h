//
//  TMLoginViewController.h
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import <UIKit/UIKit.h>

@class TMLoginViewController;

@protocol TMLoginViewControlerDelegate <NSObject>

- (void) loginDidComplete:(TMLoginViewController *)controller;

@optional

- (void) loginDidCancel:(TMLoginViewController *)controller;

@end

@interface TMLoginViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<TMLoginViewControlerDelegate> delegate;

@end
