//
//  YJLastestCityManager.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/7.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJGCity.h"

@interface YJLastestCityManager : NSObject

+ (instancetype)sharedLastestCity;

/**  插入模型数据 */
- (BOOL)insertCity:(YJGCity *)city;

/** 查询数据 */
- (NSArray *)queryCities;

/** 修改数据 */
- (BOOL)modifyCity:(NSString *)cityName;

@end
