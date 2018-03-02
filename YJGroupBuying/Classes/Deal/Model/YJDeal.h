//
//  YJDeal.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/7.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restriction.h"

@interface YJDeal : NSObject <NSCoding>

//@property (nonatomic, weak) BOOL isCollect;

//  团购所适用的商户列表
@property (nonatomic, strong) NSArray *businesses;

@property (nonatomic, copy) NSString *dealId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *listPrice;        //   原价
@property (nonatomic, copy) NSString *currentPrice;     //   团购价格

@property (nonatomic, assign)NSInteger purchaseCount;

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *sImageUrl;

@property (nonatomic, copy) NSString *publishDate;     //  团购发布上线日期
@property (nonatomic, copy) NSString *purchaseDeadline;    //  团购单的截止购买日期

@property (nonatomic, copy) NSString *dealUrl;

@property (nonatomic, copy) NSString *deal_h5_url;

//  团购详情
@property (nonatomic, copy) NSString *details;

//  restrictions    list    团购限制条件
@property (nonatomic, strong) Restriction *restrictions;

//  notice    string    重要通知(一般为团购信息的临时变更)
@property (nonatomic, copy) NSString *notice;

@property (nonatomic, strong) NSArray *categories;

@end
