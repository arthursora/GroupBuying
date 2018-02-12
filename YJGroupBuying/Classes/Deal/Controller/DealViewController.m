//
//  DealViewController.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/1.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "DealViewController.h"
#import "YJDealTool.h"
#import "YJDealParam.h"
#import "YJDealsResult.h"
#import "YJDeal.h"
#import "YJDealCell.h"
#import "YJGCity.h"
#import "YJDealTopMunu.h"
#import "YJGDistrict.h"
#import "YJCategory.h"
#import "YJOrder.h"

@interface DealViewController ()
{
    NSMutableArray *_deals;
    
    YJDealParam *_param;
}
@end

@implementation DealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    __weak typeof(self) weakself = self;
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self.collectionView.mj_footer beginRefreshing];
        [weakself loadMore];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChanged:) name:@"cityChanged" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuBtnSelected:) name:YJMenuBtnSelectedNote object:nil];
    
    _deals = [NSMutableArray array];
    _param = [[YJDealParam alloc] init];
    _param.category = @"KTV";
    _param.city = @"北京";
    _param.sort = @1;
    _param.limit = @40;
    
    [self loadMore];
}

- (void)menuBtnSelected:(NSNotification *)note {
    
    NSString *title = [note object][YJMenuBtnTitleKey];
    id model = [note object][YJMenuBtnModelKey];
    
    if ([model isKindOfClass:[YJCategory class]]) {
        if ([title isEqualToString:@"全部分类"]) {
            title = nil;
        }
        _param.category = title;
    }else if ([model isKindOfClass:[YJGDistrict class]]) {
        if ([title isEqualToString:@"全部商区"]) {
            title = nil;
        }
        _param.region = title;
    }else {
        YJOrder *order = model;
        _param.sort = @(order.index);
    }
    _param.page = nil;
    [_deals removeAllObjects];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadMore];
}

#pragma mark - viewDidLoad
- (void)setupUI {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal"]];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.frame = CGRectMake(0, 0, 260, 35);
    searchBar.placeholder = @"请输入关键字进行搜索";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    
    YJDealTopMunu *topMenu = [[YJDealTopMunu alloc] init];
    topMenu.contentView = self.view;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:topMenu];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)cityChanged:(NSNotification *)note {
    
    YJGCity *city = note.object[@"city"];
    
    _param.city = city.name;
    _param.page = nil;
    _param.region = nil;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_deals removeAllObjects];
    [self loadMore];
}

-  (void)loadMore {
    
    _param.page = @([_param.page intValue] + 1);
    [YJDealTool dealsWithParam:_param success:^(YJDealsResult *result) {
        
        [_deals addObjectsFromArray:result.deals];
        [self.collectionView reloadData];
        
        [self.collectionView.mj_footer endRefreshing];
        self.collectionView.mj_footer.hidden = _deals.count == result.totalCount;
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        
        [self.collectionView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [MBProgressHUD showError:error.domain];
    }];
}


/**
 *  创建布局
 */
- (instancetype)init {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(250, 250);
    layout.minimumLineSpacing = 20;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self resetSectionInset];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self resetSectionInset];
     } completion:nil];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)resetSectionInset {
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    CGFloat paddingX = 0;
    CGFloat paddingY = 20;
    
    NSInteger itemCount = 2;
    if(SCREEN_WIDTH > SCREEN_HEIGHT){
        itemCount = 3;
    }
    paddingX = (self.view.bounds.size.width - itemCount * layout.itemSize.width) / (itemCount + 1);
    layout.sectionInset = UIEdgeInsetsMake(paddingY, paddingX, paddingY, paddingX);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    YJLog(@"------");
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YJDealCell *cell = [YJDealCell cellWithCollectionView:collectionView indexPath:indexPath];
    cell.deal = _deals[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
