//
//  YJGDock.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/1.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJGDock;

@protocol YJGDockDelegate <NSObject>

- (void)dock:(YJGDock *)dock didSelectButtonFrom:(NSUInteger)fromIndex to:(NSUInteger)to;

@end


@interface YJGDock : UIView

@property (nonatomic, weak) id<YJGDockDelegate> delegate;

@end
