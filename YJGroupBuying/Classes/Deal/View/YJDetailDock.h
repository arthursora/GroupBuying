//
//  YJDetailDock.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/24.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJDetailDock;

@protocol YJDetailDockDelegate <NSObject>

- (void)dockView:(YJDetailDock *)detailDock didSelectBtnFrom:(NSUInteger)from to:(NSUInteger)to;

@end


@interface YJDetailDock : UIView

+ (instancetype)dock;

@property (nonatomic, weak) id<YJDetailDockDelegate> delegate;

@end
