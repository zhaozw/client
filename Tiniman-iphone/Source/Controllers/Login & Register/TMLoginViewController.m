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

#import "TMDataFacade.h"

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
    NSURL* url = [NSURL URLWithString:@"http://www.baidu.com/img/baidu_sylogo1.gif"];
    NSURL* url2 = [NSURL URLWithString:@"http://img.baidu.com/video/img/BD_video_logo.gif"];
    
    [[TMDataFacade facade] requestAvatarWithURL:url2 uid:@"uid123" timestamp:@"11a234" success:^(UIImage *avatarImage) {
        imageView.image = avatarImage;
    } fail:^(NSInteger error) {
        NSLog(@"fail");
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
