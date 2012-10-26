//
//  TMShopViewController.m
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import "TMShopViewController.h"

@interface TMShopViewController ()
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TMShopViewController

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
    [_flipButton release];
    [_tableView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setFlipButton:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - Button Actions

- (IBAction)exitFromShop:(id)sender
{
    [self.delegate shopDidExit:self];
}

- (IBAction)flipToAnotherShop:(id)sender
{
    if ([self.flipButton.titleLabel.text isEqualToString:@"Coin"]) {
        self.flipButton.titleLabel.text = @"Prop";
    } else {
        self.flipButton.titleLabel.text = @"Coin";
    }
}

#pragma mark - UITableView DataSource & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCell"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
