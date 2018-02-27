//
//  YJBuyDock.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/24.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJDeal.h"

@interface YJBuyDock : UIView

@property (nonatomic, strong) YJDeal *deal;

+ (instancetype)dock;

@end
