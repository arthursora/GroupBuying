//
//  YJDealsResult.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/7.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJDealsResult.h"
#import "YJDeal.h"

@implementation YJDealsResult


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"totalCount" : @"total_count"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             @"deals":[YJDeal class]
             };
}


@end
