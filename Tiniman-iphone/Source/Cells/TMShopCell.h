//
//  TMShopCell.h
//  Tiniman-iphone
//
//  Created by Cure on 12-10-29.
//
//

#import <UIKit/UIKit.h>
#import "TMImageTextButton.h"

@interface TMShopCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *numberLabel;
@property (retain, nonatomic) IBOutlet UILabel *infoLabel;
@property (retain, nonatomic) IBOutlet UIImageView *markImageView;
@property (retain, nonatomic) IBOutlet TMImageTextButton *purchaseButton;

@end
