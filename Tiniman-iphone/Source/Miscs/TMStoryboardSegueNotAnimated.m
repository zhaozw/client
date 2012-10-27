//
//  TMStoryboardSegueNotAnimated.m
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import "TMStoryboardSegueNotAnimated.h"

@implementation TMStoryboardSegueNotAnimated

- (void)perform
{
    [self.sourceViewController presentViewController:self.destinationViewController
                                            animated:NO
                                          completion:nil];
}

@end
