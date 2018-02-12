//
//  YJDealTopMenuButton.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/8.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJDealTopMenuButton.h"

@implementation YJDealTopMenuButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self setImage:[UIImage imageNamed:@"ic_arrow_down"] forState:UIControlStateNormal];
        
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        UIImageView *dividerView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 2, 0, 2, self.frame.size.height - 2)];
        dividerView.image = [UIImage imageNamed:@"separator_topbar_item"];
        dividerView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:dividerView];
        
        [self setBackgroundImage:[UIImage imageNamed:@"slider_filter_bg_normal"] forState:UIControlStateSelected];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
