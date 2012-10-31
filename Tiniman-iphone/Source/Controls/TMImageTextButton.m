//
//  TMImageTextButton.m
//  Tiniman-iphone
//
//  Created by Cure on 12-10-29.
//
//

#import "TMImageTextButton.h"

@implementation TMImageTextButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews {
	[super layoutSubviews];
	if (_imagePosition == TMImageTextButtonImagePositionLeft) {
		return;
	}
    
    // For TMShopButtonImagePositionRight
	CGRect imageFrame = self.imageView.frame;
	CGRect labelFrame = self.titleLabel.frame;
    
	labelFrame.origin.x = imageFrame.origin.x - self.imageEdgeInsets.left + self.imageEdgeInsets.right;
	imageFrame.origin.x += labelFrame.size.width;
    
	self.imageView.frame = imageFrame;
	self.titleLabel.frame = labelFrame;
}

@end
