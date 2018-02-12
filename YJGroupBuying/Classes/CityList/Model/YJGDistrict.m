//
//  YJGDistrict.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/2.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJGDistrict.h"

@implementation YJGDistrict

- (NSArray *)children {
    
    return _neighborhoods;
}

- (void)setNeighborhoods:(NSArray *)neighborhoods {
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"全部"];
    [array addObjectsFromArray:neighborhoods];
    _neighborhoods = array;
}

@end
