//
//  YJCategoryTool.h
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/9.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJCategoryTool : NSObject

+ (NSArray *)totalDistricts;

+ (NSArray *)totalCategories;

+ (NSString *)iconWithCategoryName:(NSString *)categoryName;

+ (NSArray *)totalOrders;

@end
