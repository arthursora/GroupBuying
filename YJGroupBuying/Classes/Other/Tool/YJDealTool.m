//
//  YJDealTool.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/8.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#define YJCollectionDealsPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"collection_deals.data"]

#import "YJDealTool.h"
#import "YJDealParam.h"
#import "YJDealsResult.h"

@interface YJDealTool()

@end

@implementation YJDealTool

static NSMutableArray *_collectionDeals;

+ (void)initialize {
    
    _collectionDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:YJCollectionDealsPath];
    if (_collectionDeals == nil) {
        _collectionDeals = [NSMutableArray array];
    }
}

+ (void)dealsWithParam:(YJDealParam *)param success:(YJDealsSuccess)success failure:(YJHttpFailure)failure {
    
    [YJHttpTool getWithUrl:@"v1/deal/find_deals" params:param.mj_keyValues success:^(id json) {
        
        YJDealsResult *resultDeals = [YJDealsResult mj_objectWithKeyValues:json];
        success(resultDeals);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)dealInfoWithId:(NSString *)dealId success:(YJDealInfoSuccess)success failure:(YJHttpFailure)failure {
    
    NSDictionary *param = @{
                            @"deal_id":dealId
                            };
    
    [YJHttpTool getWithUrl:@"v1/deal/get_single_deal" params:param success:^(id json) {
        
        YJDealsResult *resultDeals = [YJDealsResult mj_objectWithKeyValues:json];
        success([resultDeals.deals lastObject]);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSArray *)collectionDeals {
    
    return _collectionDeals;
}

+ (void)collect:(YJDeal *)deal {
    
    [_collectionDeals insertObject:deal atIndex:0];
    [NSKeyedArchiver archiveRootObject:_collectionDeals toFile:YJCollectionDealsPath];
}

+ (void)uncollect:(YJDeal *)deal {
    
    [_collectionDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:_collectionDeals toFile:YJCollectionDealsPath];
}

+ (BOOL)isCollected:(YJDeal *)deal {
    
    return [_collectionDeals containsObject:deal];
}

@end
