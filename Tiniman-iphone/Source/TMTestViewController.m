//
//  TMTestViewController.m
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import "TMTestViewController.h"
#import "TapkuLibrary.h"

@interface TMTestViewController ()

@end

@implementation TMTestViewController

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


#pragma mark - 

- (IBAction)alert:(id)sender
{
    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Hello World!"];
    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Cheers!" image:[UIImage imageNamed:@"beer.png"]];
}

@end
