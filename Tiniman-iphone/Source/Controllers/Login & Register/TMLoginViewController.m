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

@interface TMLoginViewController ()

@end

@implementation TMLoginViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //imageview
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:imageView];
    imageView.backgroundColor = [UIColor blueColor];
    [imageView release];
   
    //test avatar
//    [[TMDataTests tests] testAvatar];
    
    //test login
//    [[TMDataTests tests] testLogin];
    
//    [[TMDataTests tests] testHttpReqeust];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Logging on...";
    
    [[TMDataFacade facade] requestLoginWithUsername:@"sunny" success:^(TMUserModel *user) {
        [hud hide:YES];
        
        if (user.avatarURL)
        {
            [[TMDataFacade facade] requestAvatarWithURL:user.avatarURL uid:user.uid timestamp:user.avatarTimestamp success:^(UIImage *avatarImage) {
                imageView.image = avatarImage;
            } fail:^(NSError *error) {
                TMDataErrorLog(error);
            }];
        }
    } fail:^(NSError *error) {
        [hud hide:NO];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:error.localizedDescription image:[UIImage imageNamed:@"beer.png"]];
//        hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beer.png"]] autorelease];
//        hud.mode = MBProgressHUDModeCustomView;
//        hud.labelText = error.localizedDescription;
//        [hud hide:YES afterDelay:2.0f];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

- (IBAction)loginDidComplete:(id)sender
{
    [self.delegate loginDidComplete:self];
}

#pragma mark - MBProgressHUDDelegate Methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    [hud release];
    hud = nil;
}

@end
