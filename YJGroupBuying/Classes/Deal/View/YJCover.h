//
//  YJCover.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/24.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJCover : UIView

+ (YJCover *)showCoverInView:(UIView *)view frame:(CGRect)frame target:(id)target action:(SEL)action;

+ (void)hideCoverInView:(UIView *)view;

@end
