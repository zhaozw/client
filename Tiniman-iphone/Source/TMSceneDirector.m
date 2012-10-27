//
//  TMSceneDirector.m
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import "TMSceneDirector.h"

@implementation TMSceneDirector

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)dealloc
{
    [instanceOfSceneDirector_ release];
    instanceOfSceneDirector_ = nil;
    
    [super dealloc];
}

#pragma mark - For Singleton

static TMSceneDirector *instanceOfSceneDirector_ = nil;

+ (TMSceneDirector *)sharedSceneDirector
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanceOfSceneDirector_  = [[self alloc] init];
    });
	return instanceOfSceneDirector_;
}

#pragma mark -

- (id)viewControlleWithIdentifier:(NSString *)identitfier
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    return [mainStoryboard instantiateViewControllerWithIdentifier:identitfier];
}

- (void)showLoginSceneFrom:(UIViewController<TMLoginViewControllerDelegate> *)sourceViewController animated:(BOOL)animated
{
    TMLoginViewController *loginViewController = (TMLoginViewController *)[self viewControlleWithIdentifier:kViewControllerLogin];
    loginViewController.delegate = sourceViewController;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    
    [sourceViewController presentViewController:navigationController animated:animated completion:nil];
    [navigationController release];
}

@end
