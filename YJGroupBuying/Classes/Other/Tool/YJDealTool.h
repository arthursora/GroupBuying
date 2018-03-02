//
//  YJDealTool.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/8.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJHttpTool.h"
@class YJDealsResult, YJDealParam, YJDeal;

typedef void(^YJDealsSuccess)(YJDealsResult *result);

typedef void(^YJDealInfoSuccess)(YJDeal *result);

@interface YJDealTool : NSObject

+ (void)dealsWithParam:(YJDealParam *)param success:(YJDealsSuccess)success failure:(YJHttpFailure)failure;

+ (void)dealInfoWithId:(NSString *)dealId success:(YJDealInfoSuccess)success failure:(YJHttpFailure)failure;

+ (NSArray *)collectionDeals;

+ (BOOL)isCollected:(YJDeal *)deal;

+ (void)collect:(YJDeal *)deal;
+ (void)uncollect:(YJDeal *)deal;

@end
