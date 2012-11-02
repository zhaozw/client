//
//  TMGameListViewController.m
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import "TMGameListViewController.h"
#import "TMSceneDirector.h"
#import "TKAlertCenter.h"
#import "TMData.h"

@interface TMGameListViewController ()

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UILabel *nicknameLabel;

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
    
    [TKAlertCenter defaultCenter]; // initialize TKAlertCenter immediately for keyboard notifications
    
//    if ([[NSUserDefaults standardUserDefaults] valueForKey:kUserDefaultsToken] == nil) {
//        [[TMSceneDirector sharedSceneDirector] showLoginSceneFrom:self animated:NO];
//    }
    [[TMSceneDirector sharedSceneDirector] showLoginSceneFrom:self animated:NO initialLogin:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self unregisterFromKVO];
    
    [_tableView release];
    [_nicknameLabel release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setNicknameLabel:nil];
    [super viewDidUnload];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kStoryboardSegueShowPropShop]) {
        UINavigationController *navigationController = segue.destinationViewController;
        TMShopViewController *shopViewController = [[navigationController viewControllers] objectAtIndex:0];
        
//        shopViewController.flipButton.titleLabel.text = @"Coin";
        shopViewController.shopeType = TMShopTypeProp;
        shopViewController.delegate = self;
        
    } else if ([segue.identifier isEqualToString:kStoryboardSegueShowCoinShop]) {
        UINavigationController *navigationController = segue.destinationViewController;
        TMShopViewController *shopViewController = [[navigationController viewControllers] objectAtIndex:0];
        
//        shopViewController.flipButton.titleLabel.text = @"Prop";
        shopViewController.shopeType = TMShopTypeCoin;
        shopViewController.delegate = self;
        
    } else if ([segue.identifier isEqualToString:kStoryboardSegueShowGame]) {
        
    }
}

#pragma mark - TMLoginViewController Delegate Methods

- (void)loginDidComplete:(TMLoginViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 更新用户信息
    TMUserModel *hostUser = [[TMDataFacade facade] hostUser];
    _nicknameLabel.text = hostUser.nickname;
    
    // 注册KVO
    [self registerForKVO];
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

#pragma mark - KVO

- (void)registerForKVO
{
    [[[TMDataFacade facade] hostUser] addObserver:self forKeyPath:@"nickname" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)unregisterFromKVO
{
    [[[TMDataFacade facade] hostUser] removeObserver:self forKeyPath:@"nickname"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![NSThread isMainThread]) {
		[self performSelectorOnMainThread:@selector(updateUIForKeypath:) withObject:keyPath waitUntilDone:NO];
	} else {
		[self updateUIForKeyPath:keyPath];
	}

}

- (void)updateUIForKeyPath:(NSString *)keyPath
{
    if ([keyPath isEqualToString:@"nickname"]) {
        _nicknameLabel.text = [[[TMDataFacade facade] hostUser] nickname];
    }
}

@end
