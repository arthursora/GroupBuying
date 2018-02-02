//
//  YJGDockButton.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/1.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJGDockButton.h"

@implementation YJGDockButton

+ (instancetype)button {
    
    return [self buttonWithType:UIButtonTypeCustom];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *dividerView = [[UIImageView alloc] init];
        dividerView.image = [UIImage imageNamed:@"separator_tabbar_item"];
        dividerView.frame = CGRectMake(0, 0, YJGDockButtonW, 1);
        [self addSubview:dividerView];
        _dividerView = dividerView;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    frame.size = CGSizeMake(YJGDockButtonW, YJGDockButtonH);
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds {
    
    bounds.size = CGSizeMake(YJGDockButtonW, YJGDockButtonH);
    [super setFrame:bounds];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
