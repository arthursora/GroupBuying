//
//  YJCityTool.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/8.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJGCity.h"

@interface YJCityTool : NSObject

+ (void)addRecentCity:(YJGCity *)city;

+ (NSMutableArray *)recentCities;

+ (YJGCity *)currentCity;

+ (YJGCity *)cityWithName:(NSString *)name;

+ (NSMutableArray *)totalCities;

@end
