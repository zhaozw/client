//
//  TMImageTextButton.h
//  Tiniman-iphone
//
//  Created by Cure on 12-10-29.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    TMImageTextButtonImagePositionLeft,
    TMImageTextButtonImagePositionRight
} TMImageTextButtonImagePosition;

@interface TMImageTextButton : UIButton

@property (nonatomic, assign) TMImageTextButtonImagePosition imagePosition;

@end
