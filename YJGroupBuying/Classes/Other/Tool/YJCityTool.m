//
//  YJCityTool.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/8.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#define YJRecentCityPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"recent_cities.data"]

#import "YJCityTool.h"
#import "YJGGroup.h"

@implementation YJCityTool

static NSMutableArray *_recentCities;
static YJGCity *_currentCity;

static NSMutableArray *_groups;
static NSMutableDictionary *_allCities;

+ (void)initialize {
    
    _recentCities = [NSKeyedUnarchiver unarchiveObjectWithFile:YJRecentCityPath];
    if (_recentCities == nil) {
        _recentCities = [NSMutableArray array];
    }
    
    
    _groups = [NSMutableArray array];
    
    NSMutableArray *hotCities = [NSMutableArray array];
    
    _allCities = [NSMutableDictionary dictionary];
    NSArray *cityArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cities" ofType:@"plist"]];
    
    for (NSDictionary *cityDict in cityArr) {
        
        YJGGroup *group = [YJGGroup mj_objectWithKeyValues:cityDict];
        [_groups addObject:group];
        
        for (YJGCity *city in group.cities) {
            if (city.hot) {
                [hotCities addObject:city];
            }
            _allCities[city.name] = city;
        }
    }
    YJGGroup *hotGroup = [[YJGGroup alloc] init];
    hotGroup.name = @"热门城市";
    hotGroup.cities = hotCities;
    [_groups insertObject:hotGroup atIndex:0];
}

+ (YJGCity *)currentCity {
    
    return _currentCity;
}

+ (void)addRecentCity:(YJGCity *)city {
    
    _currentCity = city;
    [_recentCities removeObject:city.name];
    [_recentCities insertObject:city.name atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentCities toFile:YJRecentCityPath];
    
    NSDictionary *info = @{@"city":city};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cityChanged" object:info];
}

+ (NSMutableArray *)recentCities {
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:YJRecentCityPath];
}


+ (NSMutableArray *)totalCities {
    
    YJGGroup *group = _groups[0];
    if([group.name isEqualToString:@"最近访问"]) {
        [_groups removeObject:group];
    }
    
    NSArray *cityNames = [YJCityTool recentCities]; 
    if(cityNames.count) {
        
        NSMutableArray *recentCities = [NSMutableArray array];
        
        for (NSString *name in cityNames) {
            YJGCity *city = _allCities[name];
            [recentCities addObject:city];
        }
        
        YJGGroup *lastGroup = [[YJGGroup alloc] init];
        lastGroup.name = @"历史访问";
        lastGroup.cities = recentCities;
        [_groups insertObject:lastGroup atIndex:0];
    }
    return _groups;
}

+ (YJGCity *)cityWithName:(NSString *)name {
    
    return _allCities[name];
}

@end
