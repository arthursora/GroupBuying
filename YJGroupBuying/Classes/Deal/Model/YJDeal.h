//
//  YJDeal.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/7.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJDeal : NSObject

@property (nonatomic, copy) NSString *dealId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) CGFloat listPrice;        //   原价
@property (nonatomic, assign) CGFloat currentPrice;     //   团购价格

@property (nonatomic, assign)NSInteger purchaseCount;

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *sImageUrl;

@property (nonatomic, copy) NSString *publishDate;     //  团购发布上线日期
@property (nonatomic, copy) NSString *purchaseDeadline;    //  团购单的截止购买日期


@end
