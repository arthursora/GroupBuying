//
//  YJCategoryTool.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/9.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJCategoryTool.h"
#import "YJCityTool.h"
#import "YJOrder.h"
#import "YJCategory.h"

@implementation YJCategoryTool

static NSMutableArray *_totalCategories;
static NSMutableArray *_totalOrders;

+ (void)initialize {
    
    _totalCategories = [NSMutableArray array];
    _totalOrders = [NSMutableArray array];
    
    NSArray *categories = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Categories" ofType:@"plist"]];
    
    NSArray *orders = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Orders" ofType:@"plist"]];
    
    YJCategory *category = [[YJCategory alloc] init];
    category.name = @"全部分类";
    category.icon = @"ic_filter_category_-1";
    [_totalCategories addObject:category];
    for (NSDictionary *dict in categories) {
        YJCategory *category = [YJCategory mj_objectWithKeyValues:dict];
        [_totalCategories addObject:category];
    }
    
    for (int i = 0; i < orders.count; i++) {
        
        YJOrder *order = [[YJOrder alloc] init];
        order.name = orders[i];
        order.index = i + 1;
        [_totalOrders addObject:order];
    }
}

+ (NSArray *)totalDistricts {
    
    return [YJCityTool currentCity].districts;
}

+ (NSArray *)totalCategories {
    
    return _totalCategories;
}

+ (NSString *)iconWithCategoryName:(NSString *)categoryName {
    
    for (YJCategory *cate in _totalCategories) {
        
        if ([cate.name isEqualToString:categoryName] || [cate.subcategories containsObject:categoryName]) {
            return [cate.icon stringByReplacingOccurrencesOfString:@".png" withString:@""];
        }
    }
    
    return nil;
}

+ (NSArray *)totalOrders {
    
    return _totalOrders;
}

@end
