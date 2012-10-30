//
//  TMLoginViewController.m
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import "TMLoginViewController.h"

@interface TMLoginViewController ()

@end

#import "TMData.h"
#import "TMDataTests.h"
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
    [[TMDataFacade facade] requestLoginWithUsername:@"sunny" success:^(TMUserModel *user) {
        if (user.avatarURL)
        {
            [[TMDataFacade facade] requestAvatarWithURL:user.avatarURL uid:user.uid timestamp:user.avatarTimestamp success:^(UIImage *avatarImage) {
                imageView.image = avatarImage;
            } fail:^(NSError *error) {
                TMDataErrorLog(error);
            }];
        }
    } fail:^(NSError *error) {
        TMDataErrorLog(error);
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

@end
