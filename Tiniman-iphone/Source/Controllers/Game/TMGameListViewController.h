//
//  TMGameListViewController.h
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

/*!
 * TMGameListViewController
 * Tiniman-iphone
 * @author Cure
 * @copyright Tiniman Team 2012-2013 All Right Reserved
 */

#import <UIKit/UIKit.h>
#import "TMLoginViewController.h"
#import "TMShopViewController.h"

/*!
 * @class TMGameListViewController
 * @abstract  App's mainViewController contains a list of games
 */

@interface TMGameListViewController : UIViewController <TMLoginViewControllerDelegate, TMShopViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@end
