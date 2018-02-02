//
//  YJGLocationButton.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/1.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJGLocationButton.h"
#import "YJGCityListViewController.h"

@interface YJGLocationButton() <UIPopoverControllerDelegate>
{
    UIPopoverController *_popover;
}

@end

@implementation YJGLocationButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item"] forState:UIControlStateHighlighted];
        
        [self setImage:[UIImage imageNamed:@"ic_district"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"ic_district_hl"] forState:UIControlStateSelected];
        self.imageView.contentMode = UIViewContentModeCenter;
        
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addTarget:self action:@selector(locClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

- (void)locClick {
    
    self.selected = YES;
    
    YJGCityListViewController *contentVC = [[YJGCityListViewController alloc] init];
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:contentVC];
    _popover.popoverContentSize = CGSizeMake(320, 480);
    _popover.delegate = self;
    [_popover presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionUnknown animated:YES];
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    
    self.selected = NO;
    return YES;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * 0.5;
    return CGRectMake(0, 0, w, h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * 0.5;
    return CGRectMake(0, h, w, h);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
