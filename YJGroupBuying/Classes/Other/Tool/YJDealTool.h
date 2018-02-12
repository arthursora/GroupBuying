//
//  YJDealTool.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/8.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJHttpTool.h"
@class YJDealsResult, YJDealParam;

typedef void(^YJDealsSuccess)(YJDealsResult *result);

@interface YJDealTool : NSObject

+ (void)dealsWithParam:(YJDealParam *)param success:(YJDealsSuccess)success failure:(YJHttpFailure)failure;

@end
