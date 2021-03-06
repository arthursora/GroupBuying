//
//  YJGMoreButton.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/1.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJGMoreButton.h"
#import "YJMoreViewController.h"

@implementation YJGMoreButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"ic_more"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"ic_more_hl"] forState:UIControlStateHighlighted];
        
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item"] forState:UIControlStateHighlighted];
        
        [self addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

- (void)moreClick {
    
    YJMoreViewController *more = [[YJMoreViewController alloc] init];
    YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:more];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
