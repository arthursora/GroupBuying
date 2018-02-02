//
//  YJGDock.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/1.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJGDock.h"
#import "YJGMoreButton.h"
#import "YJGLocationButton.h"
#import "YJGTabButton.h"

@interface YJGDock()
{
    YJGTabButton *_selectButton;
}

@end

@implementation YJGDock

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tabbar"]];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"ic_logo"];
        imageView.frame = CGRectMake(0, 0, YJGDockButtonW, YJGDockButtonH);
        imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:imageView];
        
        YJGMoreButton *moreButton = [YJGMoreButton button];
        CGFloat moreY = SCREEN_HEIGHT - YJGDockButtonH;
        moreButton.frame = CGRectMake(0, moreY, 0, 0);
        [self addSubview:moreButton];
        
        YJGLocationButton *locationButton = [YJGLocationButton button];
        CGFloat locationY = moreY - YJGDockButtonH;
        locationButton.frame = CGRectMake(0,locationY, 0, 0);
        [self addSubview:locationButton];
        
        [self addTabButtonWithImage:@"ic_deal" selectedImage:@"ic_deal_hl" index:1];
        [self addTabButtonWithImage:@"ic_map" selectedImage:@"ic_map_hl" index:2];
        [self addTabButtonWithImage:@"ic_collect" selectedImage:@"ic_collect_hl" index:3];
        [self addTabButtonWithImage:@"ic_mine" selectedImage:@"ic_mine_hl" index:4];
        
        UIImageView *dividerView = [[UIImageView alloc] init];
        dividerView.image = [UIImage imageNamed:@"separator_tabbar_item"];
        dividerView.frame = CGRectMake(0, 5 * YJGDockButtonH, YJGDockButtonW, 1);
        [self addSubview:dividerView];
    }
    return self;
}


- (void)addTabButtonWithImage:(NSString *)image selectedImage:(NSString *)selectedImage index:(NSInteger)index {
    
    YJGTabButton *tabButton = [YJGTabButton button];
    tabButton.frame = CGRectMake(0, index * YJGDockButtonH, 0, 0);
    [tabButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [tabButton setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [tabButton addTarget:self action:@selector(tabbarAction:) forControlEvents:UIControlEventTouchDown];
    tabButton.tag = index - 1;
    [self addSubview:tabButton];
    
    if (index == 1) {
        [self tabbarAction:tabButton];
    }
}

- (void)tabbarAction:(YJGTabButton *)button {
    
    if ([_delegate respondsToSelector:@selector(dock:didSelectButtonFrom:to:)]) {
        [_delegate dock:self didSelectButtonFrom:_selectButton.tag to:button.tag];
    }
    
    _selectButton.selected = NO;
    button.selected = YES;
    _selectButton = button;
}

- (void)setFrame:(CGRect)frame {
    
    frame.size.width = YJGDockButtonW;
    [super setFrame:frame];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
