//
//  TMSceneDirector.h
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import <Foundation/Foundation.h>
#import "TMLoginViewController.h"

@interface TMSceneDirector : NSObject

+ (TMSceneDirector *)sharedSceneDirector;

- (void)showLoginSceneFrom:(UIViewController<TMLoginViewControllerDelegate> *)sourceViewController animated:(BOOL)animated;

@end
