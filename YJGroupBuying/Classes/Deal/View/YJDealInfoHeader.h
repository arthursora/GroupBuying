//
//  YJDealInfoHeader.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/28.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJDeal;

@interface YJDealInfoHeader : UIView

@property (nonatomic, strong) YJDeal *deal;

+ (instancetype)header;

@end
