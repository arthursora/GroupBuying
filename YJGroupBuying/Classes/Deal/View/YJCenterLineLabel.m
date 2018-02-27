//
//  YJCenterLineLabel.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/24.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJCenterLineLabel.h"

@implementation YJCenterLineLabel

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.textColor set];
    CGFloat startY = rect.size.height * 0.5 - 2;
    CGContextMoveToPoint(context, 0, startY);
    
    CGFloat endX = rect.size.width;
    CGContextAddLineToPoint(context, endX, startY);
    
    CGContextStrokePath(context);
}

- (void)setText:(NSString *)text {
    
    [super setText:text];
    
    CGRect f = self.frame;
    f.size.width = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]}].width + 10;
    self.frame = f;
}

@end
