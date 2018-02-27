//
//  YJCover.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/24.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJCover.h"

@implementation YJCover

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

+ (YJCover *)showCoverInView:(UIView *)view frame:(CGRect)frame target:(id)target action:(SEL)action {
    
    YJCover *coverView = [[YJCover alloc] initWithFrame:frame];
    [view addSubview:coverView];
    
    coverView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [coverView addGestureRecognizer:tapGesture];
    return coverView;
}

+ (void)hideCoverInView:(UIView *)view {
    
    for (UIView *child in view.subviews) {
        if ([child isKindOfClass:[YJCover class]]) {
            [child removeFromSuperview];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
