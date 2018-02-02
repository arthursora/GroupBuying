//
//  YJGCity.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/2.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJGCity.h"
#import "YJGDistrict.h"

@implementation YJGCity

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             @"districts":[YJGDistrict class]
             };
}

@end
