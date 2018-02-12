//
//  YJDealTool.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/8.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJDealTool.h"
#import "YJDealParam.h"
#import "YJDealsResult.h"

@implementation YJDealTool

+ (void)dealsWithParam:(YJDealParam *)param success:(YJDealsSuccess)success failure:(YJHttpFailure)failure {
    
    
    [YJHttpTool getWithUrl:@"v1/deal/find_deals" params:param.mj_keyValues success:^(id json) {
        
        YJDealsResult *resultDeals = [YJDealsResult mj_objectWithKeyValues:json];
        success(resultDeals);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
