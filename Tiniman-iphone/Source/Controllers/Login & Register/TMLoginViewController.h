//
//  TMLoginViewController.h
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class TMLoginViewController;

/*!
 * @protocol TMLoginViewControllerDelegate
 * @abstract login完成或取消后delegate需要实现的方法
 */
@protocol TMLoginViewControllerDelegate <NSObject>

/*!
 * @method loginDidComplete
 * @abstract 当login完成时
 * @param controller TMLoginViewController
 * @return void
 */
- (void) loginDidComplete:(TMLoginViewController *)controller;

@optional

/*!
 * @method loginDidCancel
 * @abstract 当login取消时
 * @param controller TMLoginViewController
 * @return void
 */
- (void) loginDidCancel:(TMLoginViewController *)controller;

@end

@interface TMLoginViewController : UIViewController <MBProgressHUDDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate, UIAlertViewDelegate>


/*!
 * @property delegate
 * @abstract loginViewController的代理(sourceViewController)
 */
@property (nonatomic, unsafe_unretained) id<TMLoginViewControllerDelegate> delegate;

/*!
 * @property initialLogin
 * @abstract 是否是app启动时的登录
 */
@property (nonatomic, assign, getter = isInitialLogin) BOOL initialLogin;

@end
