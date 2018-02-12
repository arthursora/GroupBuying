//
//  YJDealBottomMenuButton.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/9.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJDealBottomMenuButton.h"

@implementation YJDealBottomMenuButton


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_normal"] forState:UIControlStateSelected];
        
        UIImageView *dividerView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 2, 2, 2, self.frame.size.height - 4)];
        dividerView.image = [UIImage imageNamed:@"separator_topbar_item"];
        dividerView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:dividerView];
    }
    return self;
}

- (void)setBottomModel:(YJDealBottomModel *)bottomModel {
    
    _bottomModel = bottomModel;
    [self setTitle:_bottomModel.name forState:UIControlStateNormal];
    
    if(bottomModel.icon) {
        [self setImage:[UIImage imageNamed:bottomModel.icon] forState:UIControlStateNormal];
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
