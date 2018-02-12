//
//  YJGMainViewController.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/1.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJGMainViewController.h"
#import "YJGDock.h"
#import "CollectionViewController.h"
#import "DealViewController.h"
#import "MapViewController.h"
#import "ProfileViewController.h"
#import "YJNavigationController.h"

@interface YJGMainViewController () <YJGDockDelegate>

@end

@implementation YJGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    YJGDock *dockView = [[YJGDock alloc] initWithFrame:CGRectMake(0, 0, 0, SCREEN_HEIGHT)];
    dockView.delegate = self;
    [self.view addSubview:dockView];
    
    DealViewController *dealVC = [[DealViewController alloc] init];
    [self addChildVc:dealVC];
    
    MapViewController *mapVC = [[MapViewController alloc] init];
    [self addChildVc:mapVC];
    
    CollectionViewController *collectVC = [[CollectionViewController alloc] init];
    [self addChildVc:collectVC];
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    [self addChildVc:profile];
    
    [self dock:nil didSelectButtonFrom:0 to:0];
}

- (void)dock:(YJGDock *)dock didSelectButtonFrom:(NSUInteger)fromIndex to:(NSUInteger)to {
    
    YJLog(@"%@ - %@", NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.view.bounds));
    UIViewController *fromVC = self.childViewControllers[fromIndex];
    [fromVC.view removeFromSuperview];
    
    UIViewController *toVC = self.childViewControllers[to];
    toVC.view.frame = CGRectMake(YJGDockButtonW, 0, SCREEN_WIDTH - YJGDockButtonW, SCREEN_HEIGHT);
    [self.view addSubview:toVC.view];
}

- (void)addChildVc:(UIViewController *)childVc {
    
    YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
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
