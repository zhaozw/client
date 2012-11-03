//
//  TMConfigViewController.m
//  Tiniman-iphone
//
//  Created by Cure on 12-11-2.
//
//

#import "TMConfigViewController.h"
#import "TMData.h"
#import "TKAlertCenter.h"

@interface TMConfigViewController ()

@property (retain, nonatomic) IBOutlet UITextField *nicknameTextField;

@end

@implementation TMConfigViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_nicknameTextField release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setNicknameTextField:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    _nicknameTextField.placeholder  = [[[TMDataFacade facade] hostUser] nickname];
}

#pragma mark - Button Actions

- (IBAction)updateNickname:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Sending...";
    
    [[TMDataFacade facade] requestUpdateNickname:_nicknameTextField.text success:^{
        [hud hide:YES];
        _nicknameTextField.placeholder = [[[TMDataFacade facade] hostUser] nickname];
        _nicknameTextField.text = @"";
    } fail:^(NSError *error) {
        [hud hide:NO];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:error.localizedDescription image:[UIImage imageNamed:@"beer.png"]];
        CLog(error.localizedDescription);
    }];
}

#pragma mark - MBProgressHUDDelegate Methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    [hud release];
    hud = nil;
}

@end
