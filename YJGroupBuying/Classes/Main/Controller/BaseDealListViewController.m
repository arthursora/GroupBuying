//
//  BaseDealListViewController.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/28.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "BaseDealListViewController.h"
#import "YJDealCell.h"
#import "YJDeal.h"
#import "YJCover.h"
#import "DealDetailViewController.h"

@interface BaseDealListViewController ()

@end

@implementation BaseDealListViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _deals = [NSMutableArray array];
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal"]];
    
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

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YJDealCell *cell = [YJDealCell cellWithCollectionView:collectionView indexPath:indexPath];
    cell.deal = _deals[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [YJCover showCoverInView:self.navigationController.view frame:self.navigationController.view.bounds target:self action:@selector(coverDismiss)];
    
    DealDetailViewController *detailVC = [[DealDetailViewController alloc] init];
    detailVC.deal = _deals[indexPath.item];
    detailVC.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"btn_nav_close" higlightedImage:@"btn_nav_close_hl" target:self action:@selector(coverDismiss)];
    
    YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:detailVC];
    nav.view.backgroundColor = GlobalBGColor;
    CGFloat navW = YJGDetailViewWidth;
    CGFloat navH = self.navigationController.view.frame.size.height;
    CGFloat navX = self.navigationController.view.frame.size.width - YJGDetailViewWidth;
    
    nav.view.frame = CGRectMake(navX, 0, navW, navH);
    nav.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    
    [self.navigationController addChildViewController:nav];
    [self.navigationController.view addSubview:nav.view];
}

- (void)coverDismiss {
    
    [YJCover hideCoverInView:self.navigationController.view];
    
    UINavigationController *nav = [self.navigationController.childViewControllers lastObject];
    [nav.view removeFromSuperview];
    [nav removeFromParentViewController];
}


@end
