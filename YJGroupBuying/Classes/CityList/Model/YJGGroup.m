//
//  YJGGroup.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/2.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJGGroup.h"
#import "YJGCity.h"

@implementation YJGGroup

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             @"cities":[YJGCity class]
             };
}

@end
