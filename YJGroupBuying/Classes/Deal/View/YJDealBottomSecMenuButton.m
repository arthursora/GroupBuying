//
//  YJDealBottomSecMenuButton.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/11.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJDealBottomSecMenuButton.h"

@implementation YJDealBottomSecMenuButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setImage:[UIImage imageNamed:@"slider_filter_bg_active"] forState:UIControlStateSelected];
        
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    NSString *title = [self titleForState:UIControlStateNormal];
    
    CGFloat titleW = title.length * 15 + 20;
    CGFloat titleH = 30;
    CGFloat titleX = (self.frame.size.width - titleW) * 0.5;
    CGFloat titleY = (self.frame.size.height - titleH) * 0.5;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    return self.bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
