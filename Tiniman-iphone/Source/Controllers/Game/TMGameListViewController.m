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

@property (retain, nonatomic) IBOutlet UITableView *tableView;

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

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kStoryboardSegueShowPropShop]) {
        UINavigationController *navigationController = segue.destinationViewController;
        TMShopViewController *shopViewController = [[navigationController viewControllers] objectAtIndex:0];
        
        shopViewController.flipButton.titleLabel.text = @"Coin";
        shopViewController.delegate = self;
        
    } else if ([segue.identifier isEqualToString:kStoryboardSegueShowCoinShop]) {
        UINavigationController *navigationController = segue.destinationViewController;
        TMShopViewController *shopViewController = [[navigationController viewControllers] objectAtIndex:0];
        
        shopViewController.flipButton.titleLabel.text = @"Prop";
        shopViewController.delegate = self;
        
    } else if ([segue.identifier isEqualToString:kStoryboardSegueShowGame]) {
        
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

#pragma mark - UITableView Delegate & DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellGameList];
    
    cell.textLabel.text = @"New Game";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:kStoryboardSegueShowGame sender:self];
}


@end
