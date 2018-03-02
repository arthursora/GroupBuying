//
//  DealInfoViewController.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/26.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "DealInfoViewController.h"
#import "YJDealTool.h"
#import "YJDeal.h"
#import "YJDealInfoHeader.h"
#import "DealInfoTextView.h"

@interface DealInfoViewController ()

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation DealInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}

#pragma mark - viewDidLoad
- (void)setupUI {
    
    CGFloat scrollW = 430;
    CGFloat scrollX = (YJGDetailViewWidth - 60 - scrollW) / 2;
    CGFloat scrollH = self.view.mj_h;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(scrollX, 0, scrollW, scrollH)];
    scrollView.backgroundColor = GlobalBGColor;
    scrollView.bounces = YES;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
}

- (void)setupData {
    
    [YJDealTool dealInfoWithId:_deal.dealId success:^(YJDeal *result) {
        
        _deal = result;
        [self setupDealInfo];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.localizedDescription];
    }];
}

- (void)setupDealInfo {
    
    YJDealInfoHeader *infoHeader = [YJDealInfoHeader header];
    infoHeader.mj_y = 140;
    infoHeader.deal = _deal;
    [_scrollView addSubview:infoHeader];
    
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(infoHeader.frame) + 10);
    
    [self addTextView:@"ic_content" title:@"团购详情" content:_deal.details];
    [self addTextView:@"ic_content" title:@"购买须知" content:_deal.restrictions.special_tips];
    [self addTextView:@"ic_tip" title:@"重要通知" content:_deal.notice];
}

- (void)addTextView:(NSString *)icon title:(NSString *)title content:(NSString *)content {
    
    if (content.length == 0) return;
    
    DealInfoTextView *textView = [DealInfoTextView textView];
    textView.icon = icon;
    textView.title = title;
    textView.detail = content;
    [_scrollView addSubview:textView];
    
    textView.mj_y = _scrollView.contentSize.height;
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(textView.frame) + 10);;
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
