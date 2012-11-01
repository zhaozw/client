//
//  TMLoginViewController.m
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import "TMLoginViewController.h"
#import "TMData.h"
#import "TMDataTests.h"
#import "TKAlertCenter.h"

#define ALPHA                   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define NUMERIC                 @"1234567890"
#define ALPHA_NUMERIC           ALPHA NUMERIC

@interface TMLoginViewController () {
    UITapGestureRecognizer *_tapGR;
}

@property (retain, nonatomic) IBOutlet UITextField *emailTextField;
@property (retain, nonatomic) IBOutlet UIButton *startButton;
@property (retain, nonatomic) IBOutlet UIButton *facebookButton;
@property (retain, nonatomic) IBOutlet UIButton *twitterButton;

@end

@implementation TMLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
//    [[TMDataTests tests] beginTests];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_emailTextField release];
    [_startButton release];
    [_facebookButton release];
    [_twitterButton release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setEmailTextField:nil];
    [self setStartButton:nil];
    [self setFacebookButton:nil];
    [self setTwitterButton:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self isInitialLogin]) { // 当app启动时进行登录时
        if ([[[TMDataFacade facade] cacheHandler] usernameLastLogin] != nil) { // 当上次登录用户名的缓存不为空时
            _emailTextField.text = [[[TMDataFacade facade] cacheHandler] usernameLastLogin];
            
            [self loginDidStart:nil];
        }
    }
}

#pragma mark - Button Actions

- (IBAction)loginDidStart:(id)sender
{
    if (!_emailTextField.text || [_emailTextField.text isEqualToString:@""]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Please enter your email address"];
    } else if (![self validateEmailAddress:_emailTextField.text]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Please enter a valid emaill address"];
    } else {
        [_emailTextField resignFirstResponder];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.labelText = @"Logging on...";
    
        [[TMDataFacade facade] requestVerifyUsername:_emailTextField.text success:^(BOOL hasRegistered) {
            if (hasRegistered) {
                [[TMDataFacade facade] requestLoginWithUsername:_emailTextField.text success:^(TMUserModel *user) {
                    
                    [hud hide:YES];
                    [self.delegate loginDidComplete:self];
                } fail:^(NSError *error) {
                    [hud hide:NO];
                    [[TKAlertCenter defaultCenter] postAlertWithMessage:error.localizedDescription image:[UIImage imageNamed:@"beer.png"]];
                }];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Are you sure sign in with %@", _emailTextField.text] delegate:self cancelButtonTitle:@"FALSE" otherButtonTitles:@"TRUE", nil];
                [alertView show];
                [alertView release];
            }
        } fail:^(NSError *error) {
            [hud hide:NO];
            [[TKAlertCenter defaultCenter] postAlertWithMessage:error.localizedDescription image:[UIImage imageNamed:@"beer.png"]];
        }];
    }
}

#pragma mark - MBProgressHUDDelegate Methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    [hud release];
    hud = nil;
}

#pragma mark - UIGestureRecognizerDelegate Methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:_startButton]
        || [touch.view isDescendantOfView:_facebookButton]
        || [touch.view isDescendantOfView:_twitterButton]) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self loginDidStart:nil];
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:textField action:@selector(resignFirstResponder)];
    _tapGR.delegate = self;
    _tapGR.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:_tapGR];
    [_tapGR release];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_tapGR) {
        [textField removeGestureRecognizer:_tapGR];
    }
}

// 动态控制邮件地址输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = YES;
    int charsLimit = 30;

    NSCharacterSet *unacceptedInput = nil;
    if ([[textField.text componentsSeparatedByString:@"@"] count] > 1) {
        unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:[ALPHA_NUMERIC stringByAppendingFormat:@".-"]] invertedSet];
    } else {
        unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:[ALPHA_NUMERIC stringByAppendingFormat:@".!#$%&'*+-/=?^_`{|}~@"]] invertedSet];
    }
    shouldChange = [[string componentsSeparatedByCharactersInSet:unacceptedInput] count] <= 1;
    
    if (range.length <= string.length) {
        if ([[textField text] length] + string.length > charsLimit) {
            shouldChange = NO;
        }
    }
    return shouldChange;
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: // FALSE
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            break;
        case 1: // TRUE
            [[TMDataFacade facade] requestRegisterWithUsername:_emailTextField.text type:TMUserTypeEmail success:^{
                [[TMDataFacade facade] requestLoginWithUsername:_emailTextField.text success:^(TMUserModel *user) {
                    
                    
                    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
                    [self.delegate loginDidComplete:self];
                } fail:^(NSError *error) {
                    [MBProgressHUD hideHUDForView:self.navigationController.view animated:NO];
                    [[TKAlertCenter defaultCenter] postAlertWithMessage:error.localizedDescription image:[UIImage imageNamed:@"beer.png"]];
                }];
            } fail:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.navigationController.view animated:NO];
                [[TKAlertCenter defaultCenter] postAlertWithMessage:error.localizedDescription image:[UIImage imageNamed:@"beer.png"]];
            }];
            break;
        default:
            CLog(@"Error, wrong button index!");
            break;
    }
}

#pragma mark -

- (BOOL)validateEmailAddress:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
