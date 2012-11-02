//
//  TMShopViewController.m
//  Tiniman-iphone
//
//  Created by Cure on 12-10-25.
//
//

#import "TMShopViewController.h"
#import "TMData.h"
#import "MBProgressHUD.h"
#import "TKAlertCenter.h"

typedef enum {
    TMShopTableViewTagProp = 100,
    TMShopTableViewTagCoin
} TMShopTableViewTag;

@interface TMShopViewController ()

//@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIButton *flipButton;

@property (retain, nonatomic) NSArray *propListArray;
@property (retain, nonatomic) NSArray *coinListArray;
@property (retain, nonatomic) IBOutlet UIView *tableContainerView;
@property (retain, nonatomic) UITableView *propTableView;
@property (retain, nonatomic) UITableView *coinTabelView;

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

    self.coinListArray = [NSArray array];
    self.propListArray = [NSArray array];
    
    self.coinTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,_tableContainerView.bounds.size.width, _tableContainerView.bounds.size.height)
                                                      style:UITableViewStylePlain];
    _coinTabelView.delegate = self;
    _coinTabelView.dataSource = self;
    _coinTabelView.tag = TMShopTableViewTagCoin;
    [_tableContainerView addSubview:_coinTabelView];
    [_coinTabelView release];
    
    self.propTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,_tableContainerView.bounds.size.width, _tableContainerView.bounds.size.height)
                                                      style:UITableViewStylePlain];
    _propTableView.delegate = self;
    _propTableView.dataSource = self;
    _propTableView.tag = TMShopTableViewTagProp;
    [_tableContainerView addSubview:_propTableView];
    [_propTableView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_coinListArray release];
    [_propListArray release];
    
    [_flipButton release];
//    [_tableView release];
    [_tableContainerView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setFlipButton:nil];
//    [self setTableView:nil];
    [self setTableContainerView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:animated];
    hud.labelText = @"Loading...";
    
    [[TMDataFacade facade] requestShopListWithSuccessBlock:^(TMShopModel *shopModel) {
        [hud hide:YES];
        self.coinListArray = shopModel.coinPackages;
        self.propListArray = shopModel.propPackages;
        [_coinTabelView reloadData];
        [_propTableView reloadData];
    } fail:^(NSError *error) {
        [hud hide:NO];
        [[TKAlertCenter defaultCenter] postAlertWithMessage:error.localizedDescription image:[UIImage imageNamed:@"beer.png"]];
    }];
    
    if (_shopeType == TMShopTypeCoin) {
        [_flipButton setTitle:@"Prop" forState:UIControlStateNormal];
//        _propTableView.hidden = YES;
    } else {
        [_flipButton setTitle:@"Coin" forState:UIControlStateNormal];
//        _coinTabelView.hidden = YES;
    }
}

#pragma mark - Button Actions

- (IBAction)exitFromShop:(id)sender
{
    [self.delegate shopDidExit:self];
}

- (IBAction)flipToAnotherShop:(id)sender
{
    if (_shopeType == TMShopTypeProp) {
        [_flipButton setTitle:@"Prop" forState:UIControlStateNormal];
        _shopeType = TMShopTypeCoin;
    } else {
        [_flipButton setTitle:@"Coin" forState:UIControlStateNormal];
        _shopeType = TMShopTypeProp;
    }
}

#pragma mark - UITableView DataSource & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 8;
    if (tableView.tag == TMShopTableViewTagProp) {
        return [_propListArray count];
    } else {
        return [_coinListArray count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTabelViewCellShop];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTabelViewCellShop];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kTabelViewCellShop] autorelease];
    }
    
    
    
    if (TMShopTableViewTagProp == tableView.tag) {
        TMShopPropPackageModel *propPackage = [_propListArray objectAtIndex:indexPath.row];
        CLog(@"%@", propPackage);
        cell.textLabel.text = propPackage.propPackageName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", propPackage.propNumber];
    } else {
        TMShopCoinPackageModel *coinPackage = [_coinListArray objectAtIndex:indexPath.row];
        CLog(@"%@", coinPackage);
        cell.textLabel.text = coinPackage.coinPackageName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", coinPackage.coinNumber];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
