//
//  YJCategory.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/9.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJCategory.h"

@implementation YJCategory

- (NSArray *)children {
    
    return _subcategories;
}

- (void)setSubcategories:(NSArray *)subcategories {
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"全部"];
    [array addObjectsFromArray:subcategories];
    _subcategories = array;
}

@end
