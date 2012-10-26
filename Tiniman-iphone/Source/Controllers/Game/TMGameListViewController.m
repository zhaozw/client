//
//  TMGameListViewController.m
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import "TMGameListViewController.h"
#import "TMSceneDirector.h"

@interface TMGameListViewController ()

@end

@implementation TMGameListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kUserDefaultsToken] == nil) {
        [[TMSceneDirector sharedSceneDirector] showLoginSceneFrom:self animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowPropShop"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        TMShopViewController *shopViewController = [[navigationController viewControllers] objectAtIndex:0];
        
        shopViewController.flipButton.titleLabel.text = @"Coin";
        shopViewController.delegate = self;
    } else if ([segue.identifier isEqualToString:@"ShowCoinShop"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        TMShopViewController *shopViewController = [[navigationController viewControllers] objectAtIndex:0];
        
        shopViewController.flipButton.titleLabel.text = @"Prop";
        shopViewController.delegate = self;
    }
}

#pragma mark - TMLoginViewController Delegate Methods

- (void)loginDidComplete:(TMLoginViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TMShopViewController Delegate Methods

- (void)shopDidExit:(TMShopViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
