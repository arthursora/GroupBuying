//
//  DealDetailViewController.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/24.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "DealDetailViewController.h"
#import "YJBuyDock.h"
#import "YJDetailDock.h"
#import "DealInfoViewController.h"
#import "DealPicViewController.h"
#import "DealMerchatViewController.h"

@interface DealDetailViewController () <YJDetailDockDelegate>

@end

@implementation DealDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DealInfoViewController *dealInfo = [[DealInfoViewController alloc] init];
    dealInfo.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:dealInfo];
    
    DealPicViewController *dealPic = [[DealPicViewController alloc] init];
    dealPic.deal = _deal;
    [self addChildViewController:dealPic];
    
    DealMerchatViewController *dealMerchant = [[DealMerchatViewController alloc] init];
    dealMerchant.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:dealMerchant];
    
    [self dockView:nil didSelectBtnFrom:0 to:0];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)setupUI {
    
    self.title = _deal.title;
    self.view.backgroundColor = GlobalBGColor;
    
    UIBarButtonItem *collectItem = [UIBarButtonItem itemWithImage:@"ic_deal_collect" higlightedImage:@"ic_deal_collect_pressed" target:self action:@selector(collect)];
    UIBarButtonItem *shareItem = [UIBarButtonItem itemWithImage:@"btn_share" higlightedImage:@"btn_share_pressed" target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItems = @[shareItem, collectItem];
    
    YJBuyDock *buyDock = [YJBuyDock dock];
    buyDock.deal = _deal;
    buyDock.mj_y = 64;
    buyDock.mj_w = self.view.frame.size.width;
    [self.view addSubview:buyDock];
    
    YJDetailDock *detailDock = [YJDetailDock dock];
    detailDock.delegate = self;
    detailDock.mj_x = YJGDetailViewWidth - detailDock.frame.size.width;
    detailDock.mj_y = self.view.mj_h - detailDock.frame.size.height - 100;
    detailDock.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:detailDock];
}

- (void)dockView:(YJDetailDock *)detailDock didSelectBtnFrom:(NSUInteger)from to:(NSUInteger)to {
    
    UIViewController *fromVC = self.childViewControllers[from];
    [fromVC.view removeFromSuperview];
    
    UIViewController *toVC = self.childViewControllers[to];
    
    CGFloat toW = YJGDetailViewWidth - 60;
    CGFloat toH = self.view.frame.size.height;
    toVC.view.frame = CGRectMake(0, 0, toW, toH);
    YJLog(@"%@", NSStringFromCGRect(toVC.view.frame));
    
    toVC.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self.view insertSubview:toVC.view atIndex:0];
}

- (void)collect {
    YJLog(@"---collect---");
}

- (void)share {
    YJLog(@"---share---");
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
